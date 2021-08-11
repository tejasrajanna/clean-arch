import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clean/core/error/failures.dart';
import 'package:clean/core/usecases/usecase.dart';
import 'package:clean/core/util/input_converter.dart';
import 'package:clean/features/numbertrivia/domain/entities/number_trivia.dart';
import 'package:clean/features/numbertrivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean/features/numbertrivia/domain/usecases/get_random_number_trivia.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc(
      {required this.getConcreteNumberTrivia,
      required this.getRandomNumberTrivia,
      required this.inputConverter})
      : super(Empty());

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetTriviaForConcreteNumber) {
      final inputEither =
          inputConverter.stringToUnsignedInteger(event.numberString);

      yield* inputEither.fold(
        (failure) async* {
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
        },
        (integer) async* {
          yield Loading();
          final failureorTrivia = await getConcreteNumberTrivia(
            Params(number: integer),
          );
          yield* _eitherLoadedOrErrorState(failureorTrivia);
        },
      );
    } else if (event is GetTriviaForRandomNumber) {
      yield Loading();
      final failureorTrivia = await getRandomNumberTrivia(
        NoParams(),
      );
      yield* _eitherLoadedOrErrorState(failureorTrivia);
    }
  }

  Stream<NumberTriviaState> _eitherLoadedOrErrorState(
    Either<Failure, NumberTrivia> either,
  ) async* {
    yield either.fold((failure) {
      return Error(message: _mapFailureToMessage(failure));
    }, (trivia) {
      return Loaded(trivia: trivia);
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}

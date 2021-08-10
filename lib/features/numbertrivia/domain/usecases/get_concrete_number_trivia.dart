import 'package:clean/core/error/failures.dart';
import 'package:clean/core/usecases/usecase.dart';
import 'package:clean/features/numbertrivia/domain/entities/number_trivia.dart';
import 'package:clean/features/numbertrivia/domain/repositories/number_trivia_repository.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';


class GetConcreteNumberTrivia implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable
{
  final int number;
  Params({required this.number});

  @override
  List<Object?> get props => [number];
}

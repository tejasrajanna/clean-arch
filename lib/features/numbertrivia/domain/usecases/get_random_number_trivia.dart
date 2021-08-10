import 'package:clean/core/error/failures.dart';
import 'package:clean/core/usecases/usecase.dart';
import 'package:clean/features/numbertrivia/domain/entities/number_trivia.dart';
import 'package:clean/features/numbertrivia/domain/repositories/number_trivia_repository.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;
  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}



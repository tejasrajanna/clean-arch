import 'package:clean/core/error/failures.dart';
import 'package:clean/features/numbertrivia/domain/entities/number_trivia.dart';
import 'package:clean/features/numbertrivia/domain/repositories/number_trivia_repository.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';

class GetConcreteNumberTrivia {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  Future<Either<Failure, NumberTrivia>> execute({
    required int number,
  }) async {
    return await repository.getConcreteNumberTrivia(number);
  }
}

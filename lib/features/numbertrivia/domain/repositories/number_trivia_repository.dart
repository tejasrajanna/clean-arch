import 'package:clean/core/error/failures.dart';
import 'package:clean/features/numbertrivia/domain/entities/number_trivia.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:dartz/dartz.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}

import 'package:clean/core/network/network_info.dart';
import 'package:clean/core/util/input_converter.dart';
import 'package:clean/features/numbertrivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:clean/features/numbertrivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:clean/features/numbertrivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:clean/features/numbertrivia/domain/repositories/number_trivia_repository.dart';
import 'package:clean/features/numbertrivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean/features/numbertrivia/domain/usecases/get_random_number_trivia.dart';
import 'package:clean/features/numbertrivia/presentation/bloc/number_trivia_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //!Features
  //Bloc
  sl.registerFactory(() => NumberTriviaBloc(
      getConcreteNumberTrivia: sl(),
      getRandomNumberTrivia: sl(),
      inputConverter: sl()));

  //Use cases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  //Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
      () => NumberTriviaRepositoryImpl(
            remoteDataSource: sl(),
            localDataSource: sl(),
            networkInfo: sl(),
          ));

  // Data Sources
  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(
            sharedPreferences: sl(),
          ));
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
      () => NumberTriviaRemoteDataSourceImpl(
            client: sl(),
          ));

  //!Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(
        sl(),
      ));

  //!External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}

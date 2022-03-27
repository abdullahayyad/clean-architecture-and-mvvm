

import 'package:get_it/get_it.dart';
import 'package:imdb/features/now_playing/domain/usecases/get_now_playing_usecase.dart';
import 'package:imdb/features/now_playing/presentation/movie_list/viewmodel/now_playing_viewmodel.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/now_playing/data/datasources/local/now_playing_local_data_soucre.dart';
import 'features/now_playing/data/datasources/remote/now_playing_remote_data_source.dart';
import 'features/now_playing/data/repositories/now_playing_repository_impl.dart';
import 'features/now_playing/domain/Interfaces/repositories/now_play_repository.dart';
import 'package:http/http.dart' as http;



//service locator
final sl = GetIt.instance;


Future<void> init() async {

  //features
  sl.registerFactory(() => NowPlayingViewModel(getNowPlayingUseCase: sl()));


  //usecase
  sl.registerLazySingleton(() => GetNowPlayingUseCase(sl()));


  // Repository
  sl.registerLazySingleton<NowPlayingRepository>(() => NowPlayingRepositoryImpl(
      networkInfo: sl(),
      remoteDataSource: sl(),
      localDataSource: sl()
  ));


  // Data sources
  sl.registerLazySingleton<NowPlayingRemoteDataSource>(
          () => NowPlayingRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<NowPlayingLocalDataSource>(
          () => NowPlayingLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

}


import 'package:imdb/features/now_playing/data/models/movies_result_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/Interfaces/repositories/now_play_repository.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/movies_result.dart';
import '../datasources/local/now_playing_local_data_soucre.dart';
import '../datasources/remote/now_playing_remote_data_source.dart';
import '../../../../core/error/failures.dart';

import 'package:dartz/dartz.dart';

import '../models/movie_model.dart';
typedef Future<MoviesResultModel> _ConcreteOrRandomChooser();

class NowPlayingRepositoryImpl implements NowPlayingRepository {
  final NowPlayingRemoteDataSource remoteDataSource;
  final NowPlayingLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NowPlayingRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, MoviesResult>> getNowPlaying(
      int number) async {
    return await _getMoviesResult(() {
      return remoteDataSource.getNowPlaying(number)!;
    });
  }


  Future<Either<Failure, MoviesResult>> _getMoviesResult(
      _ConcreteOrRandomChooser getConcreteOrRandom) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteMovies= await getConcreteOrRandom();
        localDataSource.cacheNowPlaying(remoteMovies);
        return Right(remoteMovies);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localMovies = await localDataSource.getNowPlaying();
        return Right(localMovies!);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

}

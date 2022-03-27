import 'dart:convert';

import 'package:imdb/core/network/network_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/error/exceptions.dart';
import '../../models/movie_model.dart';
import '../../models/movies_result_model.dart';



abstract class NowPlayingLocalDataSource {
  Future<MoviesResultModel>? getNowPlaying();
  Future<void>? cacheNowPlaying(MoviesResultModel moviesToCache);
}

const CACHED_NOW_PLAYING = 'CACHED_NOW_PLAYING';

class NowPlayingLocalDataSourceImpl implements NowPlayingLocalDataSource {
  final SharedPreferences sharedPreferences;

  NowPlayingLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<MoviesResultModel>? getNowPlaying() {
    final jsonString = sharedPreferences.getString(CACHED_NOW_PLAYING);
    if (jsonString != null) {
      printIfDebug(jsonString);
      return Future.value(MoviesResultModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void>? cacheNowPlaying(MoviesResultModel moviesToCache) {
    return sharedPreferences.setString(
        CACHED_NOW_PLAYING, json.encode(moviesToCache.toJson()));
  }
}

import 'dart:convert';
import 'dart:io';


import 'package:http/http.dart' as http;
import 'package:imdb/features/now_playing/data/models/movies_result_model.dart';

import '../../../../../core/error/exceptions.dart';
import '../../models/movie_model.dart';
import 'package:imdb/core/network/network_service.dart' as ns;


abstract class NowPlayingRemoteDataSource {
  Future<MoviesResultModel>? getNowPlaying(int pageNumber);
 }

class NowPlayingRemoteDataSourceImpl implements NowPlayingRemoteDataSource {
  final http.Client client;

  NowPlayingRemoteDataSourceImpl({required this.client});

  Future<MoviesResultModel> _getNowPlayingFromUrl(String url) async {
    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final body = response.body;
      ns.printIfDebug(body);
      return MoviesResultModel.fromJson(json.decode(body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MoviesResultModel>? getNowPlaying(int number) =>
      _getNowPlayingFromUrl('https://api.themoviedb.org/3/movie/now_playing?api_key=a5398c9a5bf4e812cda2462aed852b21&language=en-US&page=$number');
}

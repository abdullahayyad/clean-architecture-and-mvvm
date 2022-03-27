

import '../../domain/entities/movie.dart';
import '../../domain/entities/movies_result.dart';
import 'movie_model.dart';

class MoviesResultModel extends MoviesResult{
  MoviesResultModel({required List<MovieModel> results, required int page, required int totalPages, required int totalResults}) : super(results: results, page: page, totalPages: totalPages, totalResults: totalResults);

  factory MoviesResultModel.fromJson(Map<String, dynamic> json) => MoviesResultModel(
      results: (json['results'] as List<dynamic>)
      .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
      .toList(),
      page: json['page'],
      totalPages: json['total_pages'],
      totalResults: json['total_results'],);


  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['page'] = page;
    _data['results'] = results.map((e)=>e.toJson()).toList();
    _data['total_pages'] = totalPages;
    _data['total_results'] = totalResults;
    return _data;
  }


}



import '../../domain/entities/movie.dart';

class MovieModel extends Movie {

  MovieModel({required bool adult, required String backdropPath, required List<
      int> genreIds, required int id, required String originalLanguage, required String originalTitle, required String overview, required double popularity, required String posterPath, required String releaseDate, required String title, required bool video, required double? voteAverage, required int voteCount})
      : super(adult: adult,
      backdropPath: backdropPath,
      genreIds: genreIds,
      id: id,
      originalLanguage: originalLanguage,
      originalTitle: originalTitle,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      releaseDate: releaseDate,
      title: title,
      video: video,
      voteAverage: voteAverage,
      voteCount: voteCount);


  factory MovieModel.fromJson(Map<String, dynamic> json){
     return MovieModel(adult: json['adult'],
        backdropPath: json['backdrop_path'],
        genreIds: List.castFrom<dynamic, int>(json['genre_ids']),
        id:  json['id'],
        originalLanguage: json['original_language'],
        originalTitle: json['original_title'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath:  json['poster_path'],
        releaseDate: json['release_date'],
        title: json['title'],
        video: json['video'],
        voteAverage: json['vote_average'].toDouble(),
        voteCount: json['vote_count']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['adult'] = adult;
    _data['backdrop_path'] = backdropPath;
    _data['genre_ids'] = genreIds;
    _data['id'] = id;
    _data['original_language'] = originalLanguage;
    _data['original_title'] = originalTitle;
    _data['overview'] = overview;
    _data['popularity'] = popularity;
    _data['poster_path'] = posterPath;
    _data['release_date'] = releaseDate;
    _data['title'] = title;
    _data['video'] = video;
    _data['vote_average'] = voteAverage;
    _data['vote_count'] = voteCount;
    return _data;
  }
}

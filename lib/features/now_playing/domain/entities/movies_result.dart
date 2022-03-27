


import '../../data/models/movie_model.dart';

class MoviesResult {
   final int page;

   final List<MovieModel> results;
   final int totalPages;
   final int totalResults;

  MoviesResult(
      {required this.results, required this.page, required this.totalPages, required this.totalResults});
}
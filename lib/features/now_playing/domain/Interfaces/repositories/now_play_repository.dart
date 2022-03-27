import 'package:dartz/dartz.dart';
import 'package:imdb/features/now_playing/domain/entities/movies_result.dart';

import '../../../../../core/error/failures.dart';
import '../../entities/movie.dart';

abstract class NowPlayingRepository {
  Future<Either<Failure, MoviesResult>>? getNowPlaying(int pageNumber);
}

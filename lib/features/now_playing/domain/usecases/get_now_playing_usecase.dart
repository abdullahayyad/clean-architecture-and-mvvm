import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../Interfaces/repositories/now_play_repository.dart';
import '../entities/movie.dart';
import '../entities/movies_result.dart';

class GetNowPlayingUseCase implements UseCase<MoviesResult, Params> {
  final NowPlayingRepository repository;

  GetNowPlayingUseCase(this.repository);

  @override
  Future<Either<Failure, MoviesResult>?> execute(Params params) async {
    return await repository.getNowPlaying(params.number);
  }
}

class Params extends Equatable {
  final int number;

  Params({required this.number});

  @override
  List<Object?> get props => [number];
}

import 'package:imdb/features/now_playing/domain/entities/movie.dart';
import 'package:imdb/features/now_playing/domain/usecases/get_now_playing_usecase.dart';
import 'package:stacked/stacked.dart';

import '../../../domain/entities/movies_result.dart';




class NowPlayingViewModel extends BaseViewModel {


  final GetNowPlayingUseCase getNowPlayingUseCase;

  late MoviesResult _moviesResult;
  MoviesResult get  moviesResult => _moviesResult;


  NowPlayingViewModel({required this.getNowPlayingUseCase});


  void getNowPlaying() async{
    setBusy(true);
    final failureOrMovie = await getNowPlayingUseCase.execute(Params(number: 1));
    failureOrMovie!.fold((failure) => setError(failure), (moviesResult) => _moviesResult = moviesResult);
    setBusy(false);
  }



}
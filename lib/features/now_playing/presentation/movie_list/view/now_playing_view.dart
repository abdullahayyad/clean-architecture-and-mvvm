import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../../../locator.dart';
import '../viewmodel/now_playing_viewmodel.dart';

class NowPlayingView extends StatelessWidget {
  const NowPlayingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NowPlayingViewModel>.reactive(
      viewModelBuilder: () => sl(),
      onModelReady: (viewModel) => viewModel.getNowPlaying(),
      disposeViewModel: false,
      builder: (context, viewModel, child) => Scaffold(
        body: Center(
          child: viewModel.isBusy
              ? CircularProgressIndicator()
              : viewModel.hasError
                  ? Text('Error Was Happen :( !!!')
                  : ListView(
                      children: ListTile.divideTiles(
                              context: context,
                              tiles: viewModel.moviesResult.results
                                  .map((element) => ListTile(
                                        contentPadding: EdgeInsets.all(8),
                                        leading: Image.network(
                                            'https://www.themoviedb.org/t/p/w220_and_h330_face/${element.posterPath}'),
                                        title: Text(element.title),
                                      ))
                                  .toList())
                          .toList(),
                    ),
        ),
      ),
    );
  }
}

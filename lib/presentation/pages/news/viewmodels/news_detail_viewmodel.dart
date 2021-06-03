import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../core/providers/app_state.dart';
import '../../../../infrastructures/models/news/news.dart';
import '../../../../infrastructures/repositories/news_repository.dart';

final newsDetailViewModel =
    ChangeNotifierProvider.autoDispose<NewsDetailViewModel>((ref) {
  return NewsDetailViewModel(ref.read);
});

class NewsDetailViewModel extends ChangeNotifier {
  final Reader _read;
  late YoutubePlayerController? controller;

  NewsDetailViewModel(this._read);

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  AppState<News> newsState = AppState.initial();

  Future<void> fetch(int id) async {
    newsState = AppState.loading();
    notifyListeners();

    try {
      final news = await _read(newsRepository).detail(id);

      newsState = AppState.data(data: news);

      if (news.typeFile == 'video') {
        controller = YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(news.linkYoutube!) ?? '',
          flags: YoutubePlayerFlags(
            autoPlay: true,
            mute: true,
          ),
        );
      }

      notifyListeners();
    } on NetworkExceptions catch (e) {
      newsState = AppState.error(message: e.message);
      notifyListeners();
    }
  }
}

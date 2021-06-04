import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/exceptions/network_exceptions.dart';
import '../../../../core/providers/app_state.dart';
import '../../../../infrastructures/models/news/news.dart';
import '../../../../infrastructures/repositories/news_repository.dart';
import '../../../../infrastructures/repositories/wishlist_repository.dart';

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
  bool isWishlisted = false;
  int? wishlistId;

  Future<void> fetch(int id) async {
    newsState = AppState.loading();
    isWishlisted = false;
    notifyListeners();

    try {
      final news = await _read(newsRepository).detail(id);

      await checkWishlisted(news.id);

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

  void launchYoutube(BuildContext context) {
    newsState.maybeWhen(
      data: (news) async {
        final url = news.linkYoutube!;
        if (await canLaunch(url)) {
          launch(url);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Could not launch $url')));
        }
      },
      orElse: () {},
    );
  }

  Future<void> checkWishlisted(int id) async {
    try {
      final wishlisted = await _read(wishlistRepository).check(id, 'news');

      isWishlisted = wishlisted.wishlisted;
      wishlistId = wishlisted.id;
    } on NetworkExceptions catch (e) {
      e.maybeWhen(
        defaultError: (message, response) {
          if (response?.statusCode == 401) return;
        },
        orElse: () {
          checkWishlisted(id);
        },
      );
    }
  }

  Future<void> addToWishlist(BuildContext context, int newsId) async {
    try {
      isWishlisted = true;
      notifyListeners();

      await _read(wishlistRepository).add(newsId, 'news');
      await checkWishlisted(newsId);
    } on NetworkExceptions catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));

      isWishlisted = false;
      notifyListeners();
    }
  }

  Future<void> removeFromWishlist(BuildContext context, int newsId) async {
    try {
      isWishlisted = false;
      notifyListeners();

      await _read(wishlistRepository).remove(wishlistId!);
      await checkWishlisted(newsId);
    } on NetworkExceptions catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));

      isWishlisted = true;
      notifyListeners();
    }
  }
}

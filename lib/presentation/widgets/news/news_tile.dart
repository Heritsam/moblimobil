import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../core/exceptions/network_exceptions.dart';
import '../../../core/themes/theme.dart';
import '../../../infrastructures/models/news/news.dart';
import '../../../infrastructures/repositories/wishlist_repository.dart';
import '../../notifiers/app_settings/app_settings_notifier.dart';
import '../../pages/account/viewmodels/account_bookmark_notifier.dart';
import '../../pages/news/news_detail_page.dart';
import '../mobli_tile.dart';

class NewsTile extends StatefulWidget {
  const NewsTile({Key? key, required this.news}) : super(key: key);

  final News news;

  @override
  _NewsTileState createState() => _NewsTileState();
}

class _NewsTileState extends State<NewsTile> {
  bool isWishlisted = false;
  int? wishlistId;

  Future<void> checkWishlisted(int id) async {
    try {
      final wishlisted =
          await context.read(wishlistRepository).check(id, 'news');

      setState(() {
        isWishlisted = wishlisted.wishlisted;
        wishlistId = wishlisted.id;
      });
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
      setState(() {
        isWishlisted = true;
      });

      await context.read(wishlistRepository).add(newsId, 'news');
      // check wishlist status
      await checkWishlisted(newsId);
      // refresh wishlist on profile page
      await context.read(accountBookmarkNotifier).getBookmarks();
    } on NetworkExceptions catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));

      setState(() {
        isWishlisted = false;
      });
    }
  }

  Future<void> removeFromWishlist(BuildContext context, int newsId) async {
    try {
      setState(() {
        isWishlisted = false;
      });

      await context.read(wishlistRepository).remove(wishlistId!);
      // check wishlist status
      await checkWishlisted(newsId);
      // refresh wishlist on profile page
      await context.read(accountBookmarkNotifier).getBookmarks();
    } on NetworkExceptions catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));

      setState(() {
        isWishlisted = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkWishlisted(widget.news.id);
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.news;

    return Consumer(
      builder: (context, watch, child) {
        final appSettings = watch(appSettingsNotifier);

        return MobliTile(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/news-detail',
              arguments: NewsDetailArgs(item.id),
            );
          },
          imageUrl: item.file,
          title: item.title,
          isVideo: item.typeFile == 'video',
          subtitle: Row(
            children: [
              Text(
                timeago.format(item.createdAt, locale: appSettings.language),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: mediumGreyColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ).expanded(),
              if (isWishlisted)
                InkResponse(
                  onTap: () {
                    removeFromWishlist(context, widget.news.id);
                  },
                  child: Icon(Icons.bookmark_rounded, color: greenColor),
                )
              else
                InkResponse(
                  onTap: () {
                    addToWishlist(context, widget.news.id);
                  },
                  child: Icon(Icons.bookmark_border_rounded),
                ),
            ],
          ),
        );
      },
    );
  }
}

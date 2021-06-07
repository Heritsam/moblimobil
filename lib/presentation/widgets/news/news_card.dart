import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/exceptions/network_exceptions.dart';
import '../../../core/themes/theme.dart';
import '../../../infrastructures/repositories/wishlist_repository.dart';
import '../../pages/account/viewmodels/account_bookmark_notifier.dart';

class NewsCard extends StatefulWidget {
  final int newsId;
  final String title;
  final String imageUrl;
  final String timestamp;
  final bool isVideo;
  final Function()? onTap;
  final double width;
  final double imageHeight;

  const NewsCard({
    Key? key,
    required this.newsId,
    required this.title,
    required this.imageUrl,
    required this.timestamp,
    required this.isVideo,
    this.onTap,
    this.width = 260,
    this.imageHeight = 160,
  }) : super(key: key);

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  bool _isPressed = false;

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
    checkWishlisted(widget.newsId);
  }

  @override
  Widget build(BuildContext context) {
    final width = widget.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: widget.imageHeight,
              width: width,
              decoration: BoxDecoration(
                color: lightGreyColor,
                image: DecorationImage(
                  image: NetworkImage(widget.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ).clipRRect(all: mediumBorderRadius),
            if (widget.isVideo)
              Icon(
                Icons.play_arrow_rounded,
                color: Colors.white,
                size: 48,
              )
                  .center()
                  .decorated(
                    shape: BoxShape.circle,
                    color: Colors.black26,
                  )
                  .backgroundBlur(20)
                  .clipRRect(all: 150)
                  .constrained(height: 52, width: 52)
                  .alignment(Alignment.center),
          ],
        ),
        SizedBox(height: 12),
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: darkGreyColor,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ).constrained(width: width),
        SizedBox(height: 12),
        Row(
          children: [
            Text(
              widget.timestamp,
              style: TextStyle(
                color: mediumGreyColor,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ).expanded(),
            if (isWishlisted)
              InkResponse(
                onTap: () {
                  removeFromWishlist(context, widget.newsId);
                },
                child: Icon(Icons.bookmark_rounded, color: greenColor),
              )
            else
              InkResponse(
                onTap: () {
                  addToWishlist(context, widget.newsId);
                },
                child: Icon(Icons.bookmark_border_rounded),
              ),
          ],
        ).constrained(width: width),
      ],
    )
        .borderRadius(all: defaultBorderRadius, animate: true)
        .gestures(
          onTapChange: (tapStatus) => setState(() => _isPressed = tapStatus),
          onTap: widget.onTap,
        )
        .scale(all: _isPressed ? 0.95 : 1.0, animate: true)
        .animate(Duration(milliseconds: 175), Curves.fastLinearToSlowEaseIn);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../widgets/error/empty_state.dart';
import 'sections/news_shimmer.dart';
import 'viewmodels/news_detail_viewmodel.dart';

class NewsDetailArgs {
  final int newsId;

  const NewsDetailArgs(this.newsId);
}

class NewsDetailPage extends StatefulWidget {
  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  late NewsDetailArgs args;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      args = ModalRoute.of(context)!.settings.arguments as NewsDetailArgs;
      context.read(newsDetailViewModel).fetch(args.newsId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white70,
        elevation: 0,
        centerTitle: false,
        title: Text(
          S.of(context).detail,
          style: TextStyle(
            color: darkGreyColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Consumer(
        builder: (context, watch, child) {
          final vm = watch(newsDetailViewModel);

          return vm.newsState.when(
            initial: () => NewsShimmer(),
            loading: () => NewsShimmer(),
            error: (message) {
              return EmptyState(
                onPressed: () {
                  vm.fetch(args.newsId);
                },
                message: message,
              );
            },
            data: (news) {
              return RefreshIndicator(
                onRefresh: () async {
                  Future.wait([
                    vm.fetch(args.newsId),
                  ]);
                },
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (news.typeFile == 'video')
                        YoutubePlayer(
                          controller: vm.controller!,
                          showVideoProgressIndicator: true,
                          bottomActions: [
                            const SizedBox(width: 14.0),
                            CurrentPosition(),
                            const SizedBox(width: 8.0),
                            ProgressBar(
                              isExpanded: true,
                              colors: ProgressBarColors(
                                playedColor: blueColor,
                                handleColor: lightBlueColor,
                              ),
                            ),
                            RemainingDuration(),
                            const SizedBox(width: 8.0),
                            IconButton(
                              onPressed: () {
                                vm.launchYoutube(context);
                              },
                              icon: Image.asset('assets/ic_youtube.png'),
                            ),
                          ],
                        )
                      else
                        Container(
                          height: size.width / 1.5,
                          width: size.width,
                          decoration: BoxDecoration(
                            color: lightGreyColor,
                            image: DecorationImage(
                              image: NetworkImage(news.file),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            timeago.format(news.createdAt),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: mediumGreyColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ).expanded(),
                          if (vm.isWishlisted)
                            IconButton(
                              onPressed: () {
                                vm.removeFromWishlist(context, news.id);
                              },
                              icon: Icon(Icons.bookmark_rounded),
                              color: greenColor,
                            )
                          else
                            IconButton(
                              onPressed: () {
                                vm.addToWishlist(context, news.id);
                              },
                              icon: Icon(Icons.bookmark_border_rounded),
                            ),
                        ],
                      ).padding(horizontal: 16),
                      SizedBox(height: 32),
                      Text(
                        news.title,
                        style: TextStyle(
                          color: darkGreyColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ).padding(horizontal: 16),
                      SizedBox(height: 16),
                      Text(news.description).padding(horizontal: 16),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

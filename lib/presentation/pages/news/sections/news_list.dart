import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../widgets/news/news_tile.dart';
import '../../../widgets/shimmer/shimmer_mobli_tile.dart';
import '../viewmodels/news_list_notifier.dart';

class NewsList extends ConsumerWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final state = watch(newsListNotifier);

    if (state.isLoading) {
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(16),
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (context, index) {
          return ShimmerMobliTile().padding(bottom: 16);
        },
      );
    }

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(16),
      shrinkWrap: true,
      itemCount: state.items.length,
      itemBuilder: (context, index) {
        final item = state.items[index];

        return NewsTile(news: item).padding(bottom: 16);
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../core/themes/theme.dart';
import '../viewmodels/news_category_notifier.dart';
import '../viewmodels/news_list_notifier.dart';

class NewsCategoryTab extends ConsumerWidget {
  const NewsCategoryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final state = watch(newsCategoryNotifier);
    final newsState = watch(newsListNotifier);

    if (state.isLoading) {
      return DefaultTabController(
        length: 5,
        child: Shimmer.fromColors(
          baseColor: lightGreyColor,
          highlightColor: Colors.white24,
          child: TabBar(
            isScrollable: true,
            physics: NeverScrollableScrollPhysics(),
            indicator: BoxDecoration(),
            labelStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: 'Montserrat',
            ),
            tabs: List.generate(5, (index) {
              return Tab(
                child: Container(
                  height: 14,
                  width: 64,
                  decoration: BoxDecoration(
                    color: lightGreyColor,
                    borderRadius: BorderRadius.circular(defaultBorderRadius),
                  ),
                ),
              );
            }),
          ),
        ),
      );
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.all(16),
      physics: BouncingScrollPhysics(),
      itemCount: state.items.length,
      itemBuilder: (context, index) {
        final item = state.items[index];

        return GestureDetector(
          onTap: () {
            newsState.changeCategory(item.id);
            newsState.fetch();
          },
          child: Text(
            item.title,
            style: newsState.selectedCategoryId == item.id
                ? TextStyle(fontWeight: FontWeight.w600)
                : null,
          ),
        ).padding(right: 16);
      },
    ).height(56);
  }
}

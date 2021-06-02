import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../core/themes/theme.dart';
import '../../../widgets/cars/car_card.dart';
import '../viewmodels/hot_deals_notifier.dart';

class HomeHotDeals extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final state = watch(hotDealsNotifier);

    if (state.isLoading) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: lightGreyColor,
            highlightColor: Colors.white24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    color: lightGreyColor,
                    borderRadius: BorderRadius.circular(mediumBorderRadius),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  height: 16,
                  width: 120,
                  decoration: BoxDecoration(
                    color: lightGreyColor,
                    borderRadius: BorderRadius.circular(mediumBorderRadius),
                  ),
                ),
                SizedBox(height: 4),
                Container(
                  height: 12,
                  width: 160,
                  decoration: BoxDecoration(
                    color: lightGreyColor,
                    borderRadius: BorderRadius.circular(mediumBorderRadius),
                  ),
                ),
              ],
            ).padding(right: 16, bottom: 32),
          );
        },
      ).constrained(height: 240);
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemCount: state.items.length,
      itemBuilder: (context, index) {
        final item = state.items[index];

        return CarCard(
          onTap: () {
            Navigator.pushNamed(context, '/cars-detail');
          },
          carId: item.id,
          title: item.title,
          price: int.tryParse(item.price) ?? 0,
          hasUsed: item.type == 'used',
          imageUrl: item.file.first.file,
        ).padding(right: 16, bottom: 32);
      },
    ).constrained(height: 240);
  }
}

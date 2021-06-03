import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../core/themes/theme.dart';
import '../../../widgets/cars/brand_item.dart';
import '../viewmodels/sort_by_brand_notifier.dart';

class HomeSortByBrand extends ConsumerWidget {
  const HomeSortByBrand({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final size = MediaQuery.of(context).size;
    final state = watch(sortByBrandNotifier);

    if (state.isLoading) {
      return Wrap(
        spacing: 10,
        runSpacing: 12,
        children: [
          'assets/brands/toyota.png',
          'assets/brands/bmw.png',
          'assets/brands/suzuki.png',
          'assets/brands/honda.png',
          'assets/brands/nissan.png',
          'assets/brands/daihatsu.png',
          'assets/brands/mitsubishi.png',
          'assets/brands/datsun.png',
        ].map((e) {
          return Shimmer.fromColors(
            baseColor: lightGreyColor,
            highlightColor: Colors.white24,
            child: Container(
              height: 73,
              width: size.width / 4 - 16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(defaultBorderRadius),
                color: lightGreyColor,
              ),
            ),
          );
        }).toList(),
      ).padding(horizontal: 16);
    }

    return Wrap(
      spacing: 10,
      runSpacing: 12,
      children: state.items.map((e) {
        return BrandItem(
          onTap: () {},
          image: NetworkImage(e.file),
        );
      }).toList(),
    ).padding(horizontal: 16);
  }
}

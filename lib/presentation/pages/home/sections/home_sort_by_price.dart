import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../widgets/cars/car_card.dart';
import '../../../widgets/cars/price_chip.dart';
import '../../../widgets/shimmer/shimmer_car_card.dart';
import '../viewmodels/sort_by_price_notifier.dart';

class HomeSortByPrice extends ConsumerWidget {
  const HomeSortByPrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final state = watch(sortByPriceNotifier);

    return Column(
      children: [
        ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16),
          itemCount: state.prices.length,
          itemBuilder: (context, index) {
            final item = state.prices[index];

            return PriceChip(
              onTap: () {
                state.changePrice(item.filter);
              },
              label: item.label,
              selected: state.filter == item.filter,
            ).padding(right: 16, bottom: 16);
          },
        ).constrained(height: 64),
        if (state.isLoading)
          ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: 6,
            itemBuilder: (context, index) {
              return ShimmerCarCard();
            },
          ).constrained(height: 240)
        else if (state.items.isEmpty)
          Text('Not Found').center().constrained(height: 240)
        else
          ListView.builder(
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
                hasUsed: index.isEven,
                imageUrl: item.file.first.file,
              ).padding(right: 16, bottom: 32);
            },
          ).constrained(height: 240),
      ],
    );
  }
}
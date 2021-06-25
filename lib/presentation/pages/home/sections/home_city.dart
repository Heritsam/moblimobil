import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../core/themes/theme.dart';
import '../../../notifiers/bottom_nav/bottom_nav_notifier.dart';
import '../../../widgets/cars/location_chip.dart';
import '../../search/viewmodels/search_viewmodel.dart';
import '../viewmodels/home_city_notifier.dart';

class HomeCity extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final size = MediaQuery.of(context).size;
    final state = watch(homeCityNotifier);

    if (state.isLoading) {
      return Wrap(
        spacing: 10,
        runSpacing: 14,
        children: List.generate(6, (_) {
          return Container(
            height: 44,
            width: size.width / 3 - 18,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(defaultBorderRadius),
              color: lightGreyColor,
            ),
          );
        }),
      );
    }

    return Wrap(
      spacing: 10,
      runSpacing: 14,
      children: state.items.map((e) {
        return LocationChip(
          onTap: () {
            context.read(bottomNavNotifier).changeIndex(1);
            context.read(searchViewModel).selectCity(e);
            context.read(searchViewModel).search();
          },
          label: e.cityName,
        ).constrained(height: 44, width: size.width / 3 - 18);
      }).toList(),
    ).padding(horizontal: 16);
  }
}

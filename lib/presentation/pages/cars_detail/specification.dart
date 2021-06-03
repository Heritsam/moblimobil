import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import 'viewmodels/cars_detail_viewmodel.dart';

class Specification extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final textTheme = Theme.of(context).textTheme;

    final vm = watch(carsDetailViewModel);

    return vm.productState.maybeWhen(
      data: (car) {
        return ExpandablePanel(
          collapsed: ExpandableButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).detail,
                  style: textTheme.headline6,
                ),
                Icon(
                  Icons.arrow_drop_down_rounded,
                  size: 32,
                  color: mediumGreyColor,
                ),
              ],
            ),
          ).center(),
          expanded: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExpandableButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).detail,
                      style: textTheme.headline6,
                    ),
                    Icon(
                      Icons.arrow_drop_up_rounded,
                      size: 32,
                      color: mediumGreyColor,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildInfo(title: 'Merk', value: car.brandName),
                      _buildInfo(title: 'Varian', value: car.variantName),
                      _buildInfo(
                          title: 'Jarak Tempuh', value: car.kilometer + ' km'),
                      _buildInfo(title: 'Warna', value: car.colorName),
                      _buildInfo(title: 'Tipe Bodi', value: car.bodyTypeName),
                    ],
                  ).expanded(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildInfo(title: 'Model', value: '-'),
                      _buildInfo(title: 'Tahun', value: car.yearProduct),
                      _buildInfo(title: 'Bahan Bakar', value: car.fuelTypeName),
                      _buildInfo(
                          title: 'Transmisi', value: car.transmissionName),
                      _buildInfo(title: 'Kota', value: '-'),
                    ],
                  ).expanded(),
                ],
              ),
            ],
          ),
        );
      },
      orElse: () {
        return SizedBox();
      },
    );
  }

  Widget _buildInfo({
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: mediumGreyColor,
          ),
        ).expanded(),
        Text(
          ': ',
          style: TextStyle(
            fontSize: 12,
            color: mediumGreyColor,
          ),
        ),
        Text(
          '$value',
          style: TextStyle(fontSize: 12),
        ).expanded(),
      ],
    ).padding(bottom: 6);
  }
}

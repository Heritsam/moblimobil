import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';

class Specification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
                  _buildInfo(title: 'Merk', value: 'Ferrari'),
                  _buildInfo(title: 'Varian', value: '-'),
                  _buildInfo(title: 'Jarak Tempuh', value: '10.000'),
                  _buildInfo(title: 'Warna', value: 'Merah'),
                  _buildInfo(title: 'Tipe Bodi', value: 'Sport'),
                ],
              ).expanded(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildInfo(title: 'Model', value: '-'),
                  _buildInfo(title: 'Tahun', value: '2000'),
                  _buildInfo(title: 'Bahan Bakar', value: 'Bensin'),
                  _buildInfo(title: 'Transmisi', value: 'Manual'),
                  _buildInfo(title: 'Kota', value: 'Jakarta'),
                ],
              ).expanded(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfo({
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: mediumGreyColor,
          ),
        ).expanded(),
        Text(
          ': $value',
          style: TextStyle(fontSize: 12),
        ).expanded(),
      ],
    ).padding(bottom: 6);
  }
}

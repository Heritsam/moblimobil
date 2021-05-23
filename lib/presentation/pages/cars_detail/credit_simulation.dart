import 'package:dropdown_search/dropdown_search.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';

class CreditSimulation extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final textTheme = Theme.of(context).textTheme;
    
    return ExpandablePanel(
      collapsed: ExpandableButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).creditSimulation,
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
                  S.of(context).creditSimulation,
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
          _buildCreditRow(
            'DP',
            DropdownSearch(
              items: ['10%', '20%', '30%'],
              hint: S.of(context).select,
              mode: Mode.BOTTOM_SHEET,
              dropdownSearchDecoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 16),
              ),
              dropDownButton: Icon(
                Icons.arrow_drop_down_rounded,
                color: mediumGreyColor,
              ),
            ),
          ),
          SizedBox(height: 16),
          _buildCreditRow(
            S.of(context).price,
            Text('250 jt').padding(all: 16),
          ),
          SizedBox(height: 16),
          _buildCreditRow(
            S.of(context).month,
            DropdownSearch(
              items: [12, 24, 36, 48, 60],
              hint: S.of(context).select,
              mode: Mode.BOTTOM_SHEET,
              dropdownSearchDecoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 16),
              ),
              dropDownButton: Icon(
                Icons.arrow_drop_down_rounded,
                color: mediumGreyColor,
              ),
            ),
          ),
          SizedBox(height: 16),
          _buildCreditRow(
            'TOTAL ${S.of(context).credit} / ${S.of(context).month}',
            Text('5 jt').padding(all: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildCreditRow(String label, Widget field) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label.toUpperCase()).fontSize(16).expanded(flex: 3),
        field
            .backgroundColor(lightGreyColor.withOpacity(.70))
            .expanded(flex: 2),
      ],
    );
  }
}

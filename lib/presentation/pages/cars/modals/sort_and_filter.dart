import 'package:dropdown_search/dropdown_search.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../core/theme.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/rounded_button.dart';

class SortAndFilter extends ConsumerWidget {
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Dialog(
      insetPadding: EdgeInsets.all(16),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close),
              color: mediumGreyColor,
            ),
          ].toRow(mainAxisAlignment: MainAxisAlignment.end),
          FadingEdgeScrollView.fromSingleChildScrollView(
            shouldDisposeScrollController: true,
            child: SingleChildScrollView(
              controller: _controller,
              child: <Widget>[
                _buildRow(
                  S.of(context).sorting,
                  DropdownSearch(
                    items: ['Relevance', ''],
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
                _buildRow(
                  S.of(context).price,
                  DropdownSearch(
                    items: ['100-200jt', '200-300jt', '300-400jt'],
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
                _buildRow(
                  S.of(context).installment,
                  DropdownSearch(
                    items: ['5jt / month', '10jt / month'],
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
                _buildRow(
                  S.of(context).city,
                  DropdownSearch(
                    items: [
                      'Jakarta',
                      'Tangerang',
                      'Bogor',
                      'Depok',
                      'Bandung',
                      'Detroit',
                    ],
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
                _buildRow(
                  S.of(context).brand,
                  DropdownSearch(
                    items: [
                      'Toyota',
                      'MINI',
                      'Tesla',
                      'Mercedes-Benz',
                      'BMW',
                      'Honda',
                    ],
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
                _buildRow(
                  S.of(context).bodyType,
                  DropdownSearch(
                    items: [
                      'MPV',
                      'Sedan',
                      'Hatchback',
                      'SUV',
                      'Convertible',
                      'Pick-up',
                    ],
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
                _buildRow(
                  S.of(context).fuelType,
                  DropdownSearch(
                    items: ['Gas', 'Electric'],
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
                _buildRow(
                  S.of(context).transmission,
                  DropdownSearch(
                    items: ['Manual', 'Matic'],
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
                _buildRow(
                  S.of(context).year,
                  DropdownSearch(
                    items: ['2000-2005', '2005-2010', '2010-2015', '2015-2020'],
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
                _buildRow(
                  S.of(context).kilometers,
                  DropdownSearch(
                    items: [
                      '1000-10000',
                      '10000-15000',
                      '15000-20000',
                      '20000-25000',
                    ],
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
                _buildRow(
                  S.of(context).color,
                  DropdownSearch(
                    items: ['Black', 'Red', 'White', 'Gold'],
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
                SizedBox(height: 32),
              ].toColumn(),
            ),
          ).expanded(),
          RoundedButton(
            label: S.of(context).sortAndFilter,
          ).padding(all: 16),
        ],
      )
          .backgroundColor(Colors.white)
          .clipRRect(all: defaultBorderRadius)
          .elevation(
            10,
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            shadowColor: Colors.black38,
          ),
    );
  }

  Widget _buildRow(String label, Widget field) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label.toUpperCase()).fontSize(14).expanded(flex: 3),
        field
            .backgroundColor(lightGreyColor.withOpacity(.70))
            .expanded(flex: 2),
      ],
    ).padding(horizontal: 16);
  }
}

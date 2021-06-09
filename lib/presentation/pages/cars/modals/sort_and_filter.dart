import 'package:dropdown_search/dropdown_search.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../core/themes/theme.dart';
import '../../../../generated/l10n.dart';
import '../../../../infrastructures/models/location/city.dart';
import '../../../../infrastructures/models/product_master/body_type.dart';
import '../../../../infrastructures/models/product_master/brand.dart';
import '../../../../infrastructures/models/product_master/car_color.dart';
import '../../../../infrastructures/models/product_master/fuel_type.dart';
import '../../../../infrastructures/models/product_master/transmission.dart';
import '../../../../infrastructures/models/sort/sort_template.dart';
import '../../../widgets/buttons/rounded_button.dart';
import '../viewmodels/car_compare_viewmodel.dart';

class SortAndFilter extends ConsumerWidget {
  final _key = GlobalKey<FormState>();
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final vm = watch(carCompareViewModel);

    return Form(
      key: _key,
      child: Dialog(
        insetPadding: EdgeInsets.all(16),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                  color: mediumGreyColor,
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.end,
            ),
            FadingEdgeScrollView.fromSingleChildScrollView(
              shouldDisposeScrollController: true,
              child: SingleChildScrollView(
                controller: _controller,
                child: <Widget>[
                  _buildRow(
                    S.of(context).sorting,
                    DropdownSearch<String>(
                      items: ['Popular', 'Latest'],
                      hint: S.of(context).select,
                      mode: Mode.BOTTOM_SHEET,
                      selectedItem: vm.sort,
                      onSaved: vm.selectSorting,
                      dropdownSearchDecoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 16),
                      ),
                      dropDownButton: Icon(
                        Icons.arrow_drop_down_rounded,
                        color: mediumGreyColor,
                      ),
                      searchBoxDecoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Search...',
                      ),
                      showSearchBox: true,
                      emptyBuilder: (context, message) {
                        return Scaffold(
                          body: Text('No Data Found').center(),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildRow(
                    S.of(context).price,
                    DropdownSearch<SortTemplate>(
                      items: SortTemplate.prices,
                      itemAsString: (item) => item.label,
                      hint: S.of(context).select,
                      mode: Mode.BOTTOM_SHEET,
                      selectedItem: vm.rangePrice,
                      onSaved: vm.selectPrice,
                      dropdownSearchDecoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 16),
                      ),
                      dropDownButton: Icon(
                        Icons.arrow_drop_down_rounded,
                        color: mediumGreyColor,
                      ),
                      searchBoxDecoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Search...',
                      ),
                      showSearchBox: true,
                      emptyBuilder: (context, message) {
                        return Scaffold(
                          body: Text('No Data Found').center(),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildRow(
                    S.of(context).city,
                    DropdownSearch<City>(
                      items: vm.cities,
                      itemAsString: (item) => item.cityName,
                      hint: S.of(context).select,
                      mode: Mode.BOTTOM_SHEET,
                      selectedItem: vm.cityId,
                      onSaved: vm.selectCity,
                      dropdownSearchDecoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 16),
                      ),
                      dropDownButton: Icon(
                        Icons.arrow_drop_down_rounded,
                        color: mediumGreyColor,
                      ),
                      searchBoxDecoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Search...',
                      ),
                      showSearchBox: true,
                      emptyBuilder: (context, message) {
                        return Scaffold(
                          body: Text('No Data Found').center(),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildRow(
                    S.of(context).brand,
                    DropdownSearch<Brand>(
                      items: vm.brands,
                      itemAsString: (item) => item.title,
                      hint: S.of(context).select,
                      mode: Mode.BOTTOM_SHEET,
                      selectedItem: vm.brandId,
                      onSaved: vm.selectBrand,
                      dropdownSearchDecoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 16),
                      ),
                      dropDownButton: Icon(
                        Icons.arrow_drop_down_rounded,
                        color: mediumGreyColor,
                      ),
                      searchBoxDecoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Search...',
                      ),
                      showSearchBox: true,
                      emptyBuilder: (context, message) {
                        return Scaffold(
                          body: Text('No Data Found').center(),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildRow(
                    S.of(context).bodyType,
                    DropdownSearch<BodyType>(
                      items: vm.bodyTypes,
                      itemAsString: (item) => item.title,
                      hint: S.of(context).select,
                      mode: Mode.BOTTOM_SHEET,
                      selectedItem: vm.bodyTypeId,
                      onSaved: vm.selectBodyType,
                      dropdownSearchDecoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 16),
                      ),
                      dropDownButton: Icon(
                        Icons.arrow_drop_down_rounded,
                        color: mediumGreyColor,
                      ),
                      searchBoxDecoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Search...',
                      ),
                      showSearchBox: true,
                      emptyBuilder: (context, message) {
                        return Scaffold(
                          body: Text('No Data Found').center(),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildRow(
                    S.of(context).fuelType,
                    DropdownSearch<FuelType>(
                      items: vm.fuelTypes,
                      itemAsString: (item) => item.title,
                      hint: S.of(context).select,
                      mode: Mode.BOTTOM_SHEET,
                      selectedItem: vm.fuelTypeId,
                      onSaved: vm.selectFuelType,
                      dropdownSearchDecoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 16),
                      ),
                      dropDownButton: Icon(
                        Icons.arrow_drop_down_rounded,
                        color: mediumGreyColor,
                      ),
                      searchBoxDecoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Search...',
                      ),
                      showSearchBox: true,
                      emptyBuilder: (context, message) {
                        return Scaffold(
                          body: Text('No Data Found').center(),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildRow(
                    S.of(context).transmission,
                    DropdownSearch<Transmission>(
                      items: vm.transmissions,
                      itemAsString: (item) => item.title,
                      hint: S.of(context).select,
                      mode: Mode.BOTTOM_SHEET,
                      selectedItem: vm.transmissionId,
                      onSaved: vm.selectTransmission,
                      dropdownSearchDecoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 16),
                      ),
                      dropDownButton: Icon(
                        Icons.arrow_drop_down_rounded,
                        color: mediumGreyColor,
                      ),
                      searchBoxDecoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Search...',
                      ),
                      showSearchBox: true,
                      emptyBuilder: (context, message) {
                        return Scaffold(
                          body: Text('No Data Found').center(),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildRow(
                    S.of(context).year,
                    DropdownSearch<SortTemplate>(
                      items: SortTemplate.byYears,
                      itemAsString: (item) => item.label,
                      hint: S.of(context).select,
                      mode: Mode.BOTTOM_SHEET,
                      selectedItem: vm.byYear,
                      onSaved: vm.selectYear,
                      dropdownSearchDecoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 16),
                      ),
                      dropDownButton: Icon(
                        Icons.arrow_drop_down_rounded,
                        color: mediumGreyColor,
                      ),
                      searchBoxDecoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Search...',
                      ),
                      showSearchBox: true,
                      emptyBuilder: (context, message) {
                        return Scaffold(
                          body: Text('No Data Found').center(),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildRow(
                    S.of(context).kilometers,
                    DropdownSearch<SortTemplate>(
                      items: SortTemplate.kilometers,
                      itemAsString: (item) => item.label,
                      hint: S.of(context).select,
                      mode: Mode.BOTTOM_SHEET,
                      selectedItem: vm.rangeKm,
                      onSaved: vm.selectKilometers,
                      dropdownSearchDecoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 16),
                      ),
                      dropDownButton: Icon(
                        Icons.arrow_drop_down_rounded,
                        color: mediumGreyColor,
                      ),
                      searchBoxDecoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Search...',
                      ),
                      showSearchBox: true,
                      emptyBuilder: (context, message) {
                        return Scaffold(
                          body: Text('No Data Found').center(),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildRow(
                    S.of(context).color,
                    DropdownSearch<CarColor>(
                      items: vm.colors,
                      itemAsString: (item) => item.title,
                      hint: S.of(context).select,
                      mode: Mode.BOTTOM_SHEET,
                      selectedItem: vm.colorId,
                      onSaved: vm.selectColor,
                      dropdownSearchDecoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 16),
                      ),
                      dropDownButton: Icon(
                        Icons.arrow_drop_down_rounded,
                        color: mediumGreyColor,
                      ),
                      searchBoxDecoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Search...',
                      ),
                      showSearchBox: true,
                      emptyBuilder: (context, message) {
                        return Scaffold(
                          body: Text('No Data Found').center(),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 32),
                ].toColumn(),
              ),
            ).expanded(),
            RoundedButton(
              onPressed: () {
                _key.currentState!.save();
                vm.fetch();
                Navigator.pop(context);
              },
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

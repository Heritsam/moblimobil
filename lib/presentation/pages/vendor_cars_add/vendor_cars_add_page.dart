import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructures/models/product_master/body_type.dart';
import '../../../infrastructures/models/product_master/brand.dart';
import '../../../infrastructures/models/product_master/car_color.dart';
import '../../../infrastructures/models/product_master/fuel_type.dart';
import '../../../infrastructures/models/product_master/transmission.dart';
import '../../../infrastructures/models/product_master/variant.dart';
import '../../widgets/buttons/rounded_button.dart';
import 'upload_image_row.dart';
import 'viewmodels/vendor_cars_add_viewmodel.dart';

enum CarStatus { newCar, usedCar }

class VendorCarsAddPage extends StatefulWidget {
  @override
  _VendorCarsAddPageState createState() => _VendorCarsAddPageState();
}

class _VendorCarsAddPageState extends State<VendorCarsAddPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read(vendorCarsAddViewModel).initialize();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Form(
      key: _formKey,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.white70,
          elevation: 0,
          centerTitle: false,
          flexibleSpace: ClipRRect(
            child: Container(color: Colors.white60).backgroundBlur(7),
          ),
          title: Text(
            'Add',
            style: TextStyle(color: darkGreyColor, fontWeight: FontWeight.w700),
          ),
        ),
        body: Consumer(
          builder: (context, watch, child) {
            final vm = watch(vendorCarsAddViewModel);

            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                top: mediaQuery.padding.top + 72,
                bottom: mediaQuery.padding.bottom + 64,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: vm.files.length + 1,
                    itemBuilder: (context, index) {
                      if (index == vm.files.length) {
                        return UploadImageRow();
                      }

                      return UploadImageRow(
                        onDelete: () {
                          vm.removeFile(index);
                        },
                        image: vm.files[index],
                      ).padding(right: 12);
                    },
                  ).constrained(height: 100),
                  SizedBox(height: 24),
                  TextFormField(
                    initialValue: vm.carName,
                    decoration: InputDecoration(
                      labelText: S.of(context).carName,
                    ),
                    onSaved: (value) {
                      vm.carName = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return 'required';
                    },
                  ).padding(horizontal: 16),
                  SizedBox(height: 16),
                  TextFormField(
                    initialValue: vm.price,
                    decoration: InputDecoration(
                      labelText: S.of(context).price,
                      prefixText: 'Rp ',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onSaved: (value) {
                      vm.price = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return 'required';
                    },
                  ).padding(horizontal: 16),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 'new',
                            groupValue: vm.type,
                            activeColor: blueColor,
                            onChanged: vm.changeType,
                          ),
                          InkResponse(
                            onTap: () {
                              vm.changeType('new');
                            },
                            child: Text('New'),
                          ),
                        ],
                      ),
                      SizedBox(width: 16),
                      Row(
                        children: [
                          Radio(
                            value: 'used',
                            groupValue: vm.type,
                            activeColor: blueColor,
                            onChanged: vm.changeType,
                          ),
                          InkResponse(
                            onTap: () {
                              vm.changeType('used');
                            },
                            child: Text('Used'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  _DropdownField<Brand>(
                    label: S.of(context).brand,
                    enabled: vm.brandState.maybeWhen(
                      data: (_) => true,
                      orElse: () => false,
                    ),
                    items: vm.brandState.maybeWhen(
                      data: (data) => data,
                      orElse: () => [],
                    ),
                    itemAsString: (item) => item.title,
                    value: vm.brandId,
                    validator: (value) {
                      if (value == null) return 'required';
                    },
                    onChanged: (value) {
                      vm.brandId = value;
                    },
                  ).padding(horizontal: 16),
                  SizedBox(height: 16),
                  _DropdownField<Variant>(
                    label: S.of(context).variant,
                    enabled: vm.variantState.maybeWhen(
                      data: (_) => true,
                      orElse: () => false,
                    ),
                    items: vm.variantState.maybeWhen(
                      data: (data) => data,
                      orElse: () => [],
                    ),
                    itemAsString: (item) => item.title,
                    value: vm.variantId,
                    validator: (value) {
                      if (value == null) return 'required';
                    },
                    onChanged: (value) {
                      vm.variantId = value;
                    },
                  ).padding(horizontal: 16),
                  SizedBox(height: 16),
                  _DropdownField<CarColor>(
                    label: S.of(context).color,
                    enabled: vm.colorState.maybeWhen(
                      data: (_) => true,
                      orElse: () => false,
                    ),
                    items: vm.colorState.maybeWhen(
                      data: (data) => data,
                      orElse: () => [],
                    ),
                    itemAsString: (item) => item.title,
                    value: vm.colorId,
                    validator: (value) {
                      if (value == null) return 'required';
                    },
                    onChanged: (value) {
                      vm.colorId = value;
                    },
                  ).padding(horizontal: 16),
                  SizedBox(height: 16),
                  _DropdownField<BodyType>(
                    label: S.of(context).bodyType,
                    enabled: vm.bodyTypeState.maybeWhen(
                      data: (_) => true,
                      orElse: () => false,
                    ),
                    items: vm.bodyTypeState.maybeWhen(
                      data: (data) => data,
                      orElse: () => [],
                    ),
                    itemAsString: (item) => item.title,
                    value: vm.bodyTypeId,
                    validator: (value) {
                      if (value == null) return 'required';
                    },
                    onChanged: (value) {
                      vm.bodyTypeId = value;
                    },
                  ).padding(horizontal: 16),
                  SizedBox(height: 16),
                  _DropdownField<FuelType>(
                    label: S.of(context).fuelType,
                    enabled: vm.fuelTypeState.maybeWhen(
                      data: (_) => true,
                      orElse: () => false,
                    ),
                    items: vm.fuelTypeState.maybeWhen(
                      data: (data) => data,
                      orElse: () => [],
                    ),
                    itemAsString: (item) => item.title,
                    value: vm.fuelTypeId,
                    validator: (value) {
                      if (value == null) return 'required';
                    },
                    onChanged: (value) {
                      vm.fuelTypeId = value;
                    },
                  ).padding(horizontal: 16),
                  SizedBox(height: 16),
                  _DropdownField<Transmission>(
                    label: S.of(context).transmission,
                    enabled: vm.transmissionState.maybeWhen(
                      data: (_) => true,
                      orElse: () => false,
                    ),
                    items: vm.transmissionState.maybeWhen(
                      data: (data) => data,
                      orElse: () => [],
                    ),
                    itemAsString: (item) => item.title,
                    value: vm.transmissionId,
                    validator: (value) {
                      if (value == null) return 'required';
                    },
                    onChanged: (value) {
                      vm.transmissionId = value;
                    },
                  ).padding(horizontal: 16),
                  SizedBox(height: 16),
                  _DropdownField<String>(
                    label: S.of(context).year,
                    items: List.generate(35, (index) {
                      final date = DateTime.now();
                      return DateTime(date.year - index).year.toString();
                    }),
                    value: vm.year,
                    dropDownButton: Icon(Icons.calendar_today),
                    validator: (value) {
                      if (value == null) return 'required';
                    },
                    onChanged: (value) {
                      vm.year = value;
                    },
                  ).padding(horizontal: 16),
                  SizedBox(height: 16),
                  TextFormField(
                    initialValue: vm.kilometers,
                    decoration: InputDecoration(
                      labelText: S.of(context).kilometers,
                      suffixText: 'Km',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onSaved: (value) {
                      vm.kilometers = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return 'Required';
                    },
                  ).padding(horizontal: 16),
                  SizedBox(height: 32),
                  Text(
                    S.of(context).description,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ).padding(horizontal: 16),
                  SizedBox(height: 16),
                  TextFormField(
                    initialValue: vm.descriptionTitle,
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                    onSaved: (value) {
                      vm.descriptionTitle = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return 'Required';
                    },
                  ).padding(horizontal: 16),
                  SizedBox(height: 24),
                  TextFormField(
                    initialValue: vm.description,
                    decoration: InputDecoration(
                      hintText: S.of(context).textField,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(mediumBorderRadius),
                      ),
                    ),
                    maxLines: 5,
                    onSaved: (value) {
                      vm.description = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return 'Required';
                    },
                  ).padding(horizontal: 16),
                  SizedBox(height: 32),
                  if (vm.isUploading)
                    RoundedButton(
                      enabled: false,
                      elevated: false,
                      label: 'Loading...',
                      horizontalPadding: 64,
                    ).center()
                  else
                    RoundedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          vm.addProduct(context);
                        }
                      },
                      label: S.of(context).save,
                      horizontalPadding: 64,
                    ).center(),
                  SizedBox(height: mediaQuery.padding.bottom + 32),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _DropdownField<T> extends StatelessWidget {
  final String label;
  final bool enabled;
  final List<T> items;
  final String Function(T)? itemAsString;
  final Function(T?)? onChanged;
  final T? value;
  final String? Function(T?)? validator;
  final Widget? dropDownButton;

  const _DropdownField({
    Key? key,
    required this.label,
    this.enabled = true,
    required this.items,
    this.itemAsString,
    this.onChanged,
    this.value,
    this.validator,
    this.dropDownButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>(
      enabled: enabled,
      items: items,
      itemAsString: itemAsString,
      onChanged: onChanged,
      mode: Mode.BOTTOM_SHEET,
      showSearchBox: true,
      selectedItem: value,
      searchBoxDecoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Search...',
      ),
      dropdownSearchDecoration: InputDecoration(
        labelText: label,
        hintText: label,
        contentPadding: EdgeInsets.zero,
      ),
      dropDownButton: dropDownButton ??
          Icon(
            Icons.arrow_drop_down_rounded,
            color: mediumGreyColor,
          ),
      validator: validator,
      emptyBuilder: (context, message) {
        return Scaffold(
          body: Text('No Data Found').center(),
        );
      },
    );
  }
}

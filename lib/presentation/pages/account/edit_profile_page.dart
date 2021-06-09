import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructures/models/location/city.dart';
import '../../../infrastructures/models/location/province.dart';
import '../../../infrastructures/models/location/subdistrict.dart';
import '../../widgets/buttons/rounded_button.dart';
import '../../widgets/circle_image.dart';
import '../../widgets/error/empty_state.dart';
import '../../widgets/mobli_loading_indicator.dart';
import 'viewmodels/edit_profile_viewmodel.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read(editProfileViewModel).fetchUser();
      context.read(editProfileViewModel).fetchProvinces();
    });
  }

  @override
  void dispose() {
    super.dispose();
    context.read(editProfileViewModel).dispose();
  }

  Future<void> _pickImage(EditProfileViewModel vm) async {
    if (vm.newAvatar != null) {
      vm.newAvatar = null;
      setState(() {});
      return;
    }

    final pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (pickedFile != null) {
      vm.newAvatar = File(pickedFile.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Form(
      key: _formKey,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: Colors.white70,
          elevation: 0,
          centerTitle: false,
          title: Text(
            S.of(context).editProfile,
            style: TextStyle(color: darkGreyColor, fontWeight: FontWeight.w700),
          ),
          flexibleSpace: ClipRRect(
            child: Container(color: Colors.white60).backgroundBlur(7),
          ),
        ),
        body: Consumer(
          builder: (context, watch, child) {
            final vm = watch(editProfileViewModel);

            return vm.userState.when(
              initial: () => MobliLoadingIndicator(),
              loading: () => MobliLoadingIndicator(),
              error: (message) {
                return EmptyState(
                  onPressed: () {
                    vm.fetchUser();
                  },
                  message: message,
                );
              },
              data: (user) {
                return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                    top: mediaQuery.padding.top + 56 + 16,
                    left: 16,
                    right: 16,
                    bottom: 32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleImage(
                            size: 120,
                            image: AssetImage('assets/profile_picture.png'),
                          ),
                          if (vm.avatar != null)
                            CircleImage(
                              size: 120,
                              image: NetworkImage(vm.avatar!),
                            ),
                          if (vm.newAvatar != null)
                            CircleImage(
                              size: 120,
                              image: FileImage(vm.newAvatar!),
                            ),
                          Icon(
                            vm.newAvatar != null
                                ? Icons.close
                                : Icons.camera_alt_outlined,
                            color: Colors.black45,
                            size: 28,
                          )
                              .padding(all: 8)
                              .decorated(
                                color: Colors.white24,
                                shape: BoxShape.circle,
                              )
                              .backgroundBlur(7)
                              .clipOval(),
                        ],
                      )
                          .constrained(height: 120, width: 120)
                          .gestures(onTap: () => _pickImage(vm))
                          .center(),
                      SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: S.of(context).fullNameField,
                        ),
                        initialValue: user.fullname,
                        onSaved: (value) {
                          vm.fullname = value!;
                        },
                        validator: (value) {
                          if (value!.isEmpty) return 'Required';
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: S.of(context).emailField,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        initialValue: user.email,
                        onSaved: (value) {
                          vm.email = value!;
                        },
                        validator: (value) {
                          final emailFormat = RegExp(
                            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?",
                          );

                          if (value!.isEmpty) {
                            return 'Required';
                          }

                          if (!emailFormat.hasMatch(value)) {
                            return 'Enter valid email address';
                          }
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: S.of(context).phoneField,
                        ),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        initialValue: user.phone,
                        onSaved: (value) {
                          vm.phone = value!;
                        },
                        validator: (value) {
                          if (value!.isEmpty) return 'Required';
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: vm.birthController,
                        decoration: InputDecoration(
                          labelText: S.of(context).birthField,
                          suffixIcon: Icon(Icons.calendar_today_rounded),
                        ),
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: user.bornDate ?? DateTime.now(),
                            initialDatePickerMode: DatePickerMode.day,
                            firstDate: DateTime(1940),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            vm.birthController.text =
                                DateFormat('yyyy-MM-dd').format(picked);
                          }
                        },
                        readOnly: true,
                        validator: (value) {
                          if (value!.isEmpty) return 'Required';
                        },
                      ),
                      SizedBox(height: 32),
                      vm.provinceState.when(
                        initial: () =>
                            _buildEmptyDropdown(S.of(context).selectProvince),
                        loading: () =>
                            _buildEmptyDropdown(S.of(context).selectProvince),
                        error: (_) =>
                            _buildEmptyDropdown(S.of(context).selectProvince),
                        data: (items) {
                          return _buildProvinceField(
                            context,
                            onChanged: (value) {
                              vm.provinceId = int.parse(value!.provinceId);
                              vm.fetchCities();
                            },
                            items: items,
                            enabled: true,
                            value: vm.provinceId != 0
                                ? items.firstWhere(
                                    (item) =>
                                        item.provinceId ==
                                        vm.provinceId.toString(),
                                    orElse: () => items[0],
                                  )
                                : null,
                          );
                        },
                      ),
                      SizedBox(height: 16),
                      vm.cityState.when(
                        initial: () =>
                            _buildEmptyDropdown(S.of(context).selectCity),
                        loading: () =>
                            _buildEmptyDropdown(S.of(context).selectCity),
                        error: (_) =>
                            _buildEmptyDropdown(S.of(context).selectCity),
                        data: (items) {
                          return _buildCityField(
                            context,
                            onChanged: (value) {
                              vm.cityId = value!.cityId;
                              vm.fetchSubdistricts();
                            },
                            items: items,
                            enabled: true,
                            value: vm.cityId != 0
                                ? items.firstWhere(
                                    (item) => item.cityId == vm.cityId,
                                    orElse: () => items[0],
                                  )
                                : null,
                          );
                        },
                      ),
                      SizedBox(height: 16),
                      vm.subdistrictState.when(
                        initial: () => _buildEmptyDropdown(
                            S.of(context).selectSubDistrict),
                        loading: () => _buildEmptyDropdown(
                            S.of(context).selectSubDistrict),
                        error: (_) => _buildEmptyDropdown(
                            S.of(context).selectSubDistrict),
                        data: (items) {
                          return _buildSubdistrictField(
                            context,
                            onChanged: (value) {
                              vm.subdistrictId =
                                  int.parse(value!.subdistrictId);
                            },
                            items: items,
                            enabled: true,
                            value: vm.subdistrictId != 0
                                ? items.firstWhere(
                                    (item) =>
                                        item.subdistrictId ==
                                        vm.subdistrictId.toString(),
                                    orElse: () => items[0],
                                  )
                                : null,
                          );
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: S.of(context).addressField,
                        ),
                        initialValue: user.address,
                        onSaved: (value) {
                          vm.address = value!;
                        },
                        validator: (value) {
                          if (value!.isEmpty) return 'Required';
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: S.of(context).zipCodeField,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
                        initialValue: user.postcode,
                        onSaved: (value) {
                          vm.postcode = value!;
                        },
                        validator: (value) {
                          if (value!.isEmpty) return 'Required';
                        },
                      ),
                      SizedBox(height: 32),
                      if (vm.isUpdating)
                        RoundedButton(
                          enabled: false,
                          label: 'LOADING...',
                          horizontalPadding: 64,
                        )
                      else
                        RoundedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              vm.updateProfile(context);
                            }
                          },
                          label: S.of(context).save,
                          horizontalPadding: 64,
                        ),
                      SizedBox(height: 64),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmptyDropdown(String label) {
    return DropdownSearch(
      enabled: false,
      dropdownSearchDecoration: InputDecoration(
        labelText: label,
        contentPadding: EdgeInsets.zero,
        errorStyle: TextStyle(
          color: redColor,
        ),
      ),
      dropDownButton: Icon(
        Icons.arrow_drop_down_rounded,
        color: mediumGreyColor,
      ),
      validator: (_) {
        return 'Required';
      },
      emptyBuilder: (context, message) {
        return Scaffold(
          body: Text('No Data Found').center(),
        );
      },
    );
  }

  Widget _buildProvinceField(
    BuildContext context, {
    Function(Province?)? onChanged,
    bool enabled = false,
    List<Province>? items,
    Province? value,
  }) {
    return DropdownSearch<Province>(
      enabled: enabled,
      items: items,
      itemAsString: (item) => item.provinceName,
      onChanged: onChanged,
      mode: Mode.BOTTOM_SHEET,
      showSearchBox: true,
      selectedItem: value,
      searchBoxDecoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Search...',
      ),
      dropdownSearchDecoration: InputDecoration(
        labelText: S.of(context).selectProvince,
        contentPadding: EdgeInsets.zero,
      ),
      dropDownButton: Icon(
        Icons.arrow_drop_down_rounded,
        color: mediumGreyColor,
      ),
      validator: (value) {
        if (value == null) return 'Required';
      },
      emptyBuilder: (context, message) {
        return Scaffold(
          body: Text('No Data Found').center(),
        );
      },
    );
  }

  Widget _buildCityField(
    BuildContext context, {
    Function(City?)? onChanged,
    bool enabled = false,
    List<City>? items,
    City? value,
  }) {
    return DropdownSearch<City>(
      enabled: enabled,
      items: items,
      itemAsString: (item) => item.cityName,
      onChanged: onChanged,
      mode: Mode.BOTTOM_SHEET,
      showSearchBox: true,
      selectedItem: value,
      searchBoxDecoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Search...',
      ),
      dropdownSearchDecoration: InputDecoration(
        labelText: S.of(context).selectCity,
        contentPadding: EdgeInsets.zero,
      ),
      dropDownButton: Icon(
        Icons.arrow_drop_down_rounded,
        color: mediumGreyColor,
      ),
      emptyBuilder: (context, message) {
        return Scaffold(
          body: Text('No Data Found').center(),
        );
      },
    );
  }

  Widget _buildSubdistrictField(
    BuildContext context, {
    Function(Subdistrict?)? onChanged,
    bool enabled = false,
    List<Subdistrict>? items,
    Subdistrict? value,
  }) {
    return DropdownSearch<Subdistrict>(
      enabled: enabled,
      items: items,
      itemAsString: (item) => item.subdistrictName,
      onChanged: onChanged,
      mode: Mode.BOTTOM_SHEET,
      showSearchBox: true,
      selectedItem: value,
      searchBoxDecoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Search...',
      ),
      dropdownSearchDecoration: InputDecoration(
        labelText: S.of(context).selectSubDistrict,
        contentPadding: EdgeInsets.zero,
      ),
      dropDownButton: Icon(
        Icons.arrow_drop_down_rounded,
        color: mediumGreyColor,
      ),
      emptyBuilder: (context, message) {
        return Scaffold(
          body: Text('No Data Found').center(),
        );
      },
    );
  }
}

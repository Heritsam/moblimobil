import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructures/models/car.dart';
import '../../widgets/buttons/rounded_button.dart';
import 'upload_image_row.dart';

enum CarStatus { newCar, usedCar }

class VendorCarsAddPage extends StatefulWidget {
  @override
  _VendorCarsAddPageState createState() => _VendorCarsAddPageState();
}

class _VendorCarsAddPageState extends State<VendorCarsAddPage> {
  CarStatus? _newOrUsed = CarStatus.newCar;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
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
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: mediaQuery.padding.top + 72,
          bottom: mediaQuery.padding.bottom + 64,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              itemBuilder: (context, index) {
                return UploadImageRow(image: index == 0).padding(right: 12);
              },
            ).constrained(height: 100),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: S.of(context).carName,
              ),
            ).padding(horizontal: 16),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: S.of(context).price,
                prefixText: 'Rp ',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ).padding(horizontal: 16),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Radio(
                      value: CarStatus.newCar,
                      groupValue: _newOrUsed,
                      activeColor: blueColor,
                      onChanged: (CarStatus? value) {
                        setState(() {
                          _newOrUsed = value;
                        });
                      },
                    ),
                    InkResponse(
                      onTap: () {
                        setState(() {
                          _newOrUsed = CarStatus.newCar;
                        });
                      },
                      child: Text('New'),
                    ),
                  ],
                ),
                SizedBox(width: 16),
                Row(
                  children: [
                    Radio(
                      value: CarStatus.usedCar,
                      groupValue: _newOrUsed,
                      activeColor: blueColor,
                      onChanged: (CarStatus? value) {
                        setState(() {
                          _newOrUsed = value;
                        });
                      },
                    ),
                    InkResponse(
                      onTap: () {
                        setState(() {
                          _newOrUsed = CarStatus.usedCar;
                        });
                      },
                      child: Text('Used'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 4),
            DropdownSearch(
              mode: Mode.BOTTOM_SHEET,
              items: carList,
              itemAsString: (Car item) => item.brand,
              dropdownSearchDecoration: InputDecoration(
                labelText: S.of(context).brand,
                contentPadding: EdgeInsets.zero,
              ),
            ).padding(horizontal: 16),
            SizedBox(height: 16),
            DropdownSearch(
              mode: Mode.BOTTOM_SHEET,
              items: ['Varian', 'Varian', 'Varian'],
              dropdownSearchDecoration: InputDecoration(
                labelText: S.of(context).variant,
                contentPadding: EdgeInsets.zero,
              ),
            ).padding(horizontal: 16),
            SizedBox(height: 16),
            DropdownSearch(
              mode: Mode.BOTTOM_SHEET,
              items: ['Color', 'Color', 'Color'],
              dropdownSearchDecoration: InputDecoration(
                labelText: S.of(context).color,
                contentPadding: EdgeInsets.zero,
              ),
            ).padding(horizontal: 16),
            SizedBox(height: 16),
            DropdownSearch(
              mode: Mode.BOTTOM_SHEET,
              items: ['Sedan', 'MPV', 'SUV', 'Convertible'],
              dropdownSearchDecoration: InputDecoration(
                labelText: S.of(context).bodyType,
                contentPadding: EdgeInsets.zero,
              ),
            ).padding(horizontal: 16),
            SizedBox(height: 16),
            DropdownSearch(
              mode: Mode.BOTTOM_SHEET,
              items: ['Model', 'Model', 'Model'],
              dropdownSearchDecoration: InputDecoration(
                labelText: S.of(context).model,
                contentPadding: EdgeInsets.zero,
              ),
            ).padding(horizontal: 16),
            SizedBox(height: 16),
            DropdownSearch(
              mode: Mode.BOTTOM_SHEET,
              items: ['Fuel Type', 'Fuel Type', 'Fuel Type'],
              dropdownSearchDecoration: InputDecoration(
                labelText: S.of(context).fuelType,
                contentPadding: EdgeInsets.zero,
              ),
            ).padding(horizontal: 16),
            SizedBox(height: 16),
            DropdownSearch(
              mode: Mode.BOTTOM_SHEET,
              items: ['Transmission', 'Transmission', 'Transmission'],
              dropdownSearchDecoration: InputDecoration(
                labelText: S.of(context).transmission,
                contentPadding: EdgeInsets.zero,
              ),
            ).padding(horizontal: 16),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: S.of(context).year,
                suffixIcon: Icon(Icons.calendar_today),
              ),
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
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ).padding(horizontal: 16),
            SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(
                hintText: S.of(context).textField,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(mediumBorderRadius),
                ),
              ),
              maxLines: 5,
            ).padding(horizontal: 16),
            SizedBox(height: 32),
            RoundedButton(
              label: S.of(context).save,
              horizontalPadding: 64,
            ).center(),
            SizedBox(height: mediaQuery.padding.bottom + 32),
          ],
        ),
      ),
    );
  }
}

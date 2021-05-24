import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../widgets/buttons/rounded_button.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
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
      body: SingleChildScrollView(
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
              children: [
                Styled.widget().decorated(
                  color: lightGreyColor,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://uifaces.co/our-content/donated/gPZwCbdS.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ).constrained(height: 120, width: 120).center(),
            SizedBox(height: 32),
            TextField(
              decoration: InputDecoration(
                labelText: S.of(context).fullNameField,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: S.of(context).emailField,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            DropdownSearch(
              mode: Mode.BOTTOM_SHEET,
              items: [
                S.of(context).male,
                S.of(context).female,
              ],
              dropdownSearchDecoration: InputDecoration(
                labelText: S.of(context).selectGender,
                contentPadding: EdgeInsets.zero,
              ),
              dropDownButton: Icon(
                Icons.arrow_drop_down_rounded,
                color: mediumGreyColor,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: S.of(context).birthField,
                suffixIcon: Icon(Icons.calendar_today_rounded),
              ),
            ),
            SizedBox(height: 32),
            DropdownSearch(
              mode: Mode.BOTTOM_SHEET,
              items: [
                'Jawa Barat',
                'Jawa Tengah',
                'Jawa Timur',
              ],
              dropdownSearchDecoration: InputDecoration(
                labelText: S.of(context).selectProvince,
                contentPadding: EdgeInsets.zero,
              ),
              dropDownButton: Icon(
                Icons.arrow_drop_down_rounded,
                color: mediumGreyColor,
              ),
            ),
            SizedBox(height: 16),
            DropdownSearch(
              mode: Mode.BOTTOM_SHEET,
              items: [
                'Jakarta',
                'Tangerang',
                'Bogor',
                'Depok',
                'Bandung',
                'Detroit',
              ],
              dropdownSearchDecoration: InputDecoration(
                labelText: S.of(context).selectCity,
                contentPadding: EdgeInsets.zero,
              ),
              dropDownButton: Icon(
                Icons.arrow_drop_down_rounded,
                color: mediumGreyColor,
              ),
            ),
            SizedBox(height: 16),
            DropdownSearch(
              mode: Mode.BOTTOM_SHEET,
              items: [
                'Jakarta Selatan',
                'Tangerang Selatan',
                'Bogor Selatan',
                'Depok',
                'Bandung',
                'Detroit',
              ],
              dropdownSearchDecoration: InputDecoration(
                labelText: S.of(context).selectSubDistrict,
                contentPadding: EdgeInsets.zero,
              ),
              dropDownButton: Icon(
                Icons.arrow_drop_down_rounded,
                color: mediumGreyColor,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: S.of(context).addressField,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: S.of(context).zipCodeField,
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 32),
            RoundedButton(
              onPressed: () {},
              label: S.of(context).save,
              horizontalPadding: 64,
            ),
            SizedBox(height: 64),
          ],
        ),
      ),
    );
  }
}

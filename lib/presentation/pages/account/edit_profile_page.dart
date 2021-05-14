import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:moblimobil/presentation/widgets/buttons/rounded_button.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/theme.dart';
import '../../../generated/l10n.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
          style: textTheme.headline6?.copyWith(color: darkGreyColor),
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
                hintText: S.of(context).fullNameField,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 18),
                hintStyle: TextStyle(color: mediumGreyColor),
              ),
            ).decorated(
              color: inputFieldColor,
              borderRadius: BorderRadius.circular(defaultBorderRadius),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: S.of(context).emailField,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 18),
                hintStyle: TextStyle(color: mediumGreyColor),
              ),
              keyboardType: TextInputType.emailAddress,
            ).decorated(
              color: inputFieldColor,
              borderRadius: BorderRadius.circular(defaultBorderRadius),
            ),
            SizedBox(height: 16),
            DropdownSearch(
              mode: Mode.BOTTOM_SHEET,
              items: [
                S.of(context).male,
                S.of(context).female,
              ],
              dropdownSearchDecoration: InputDecoration(
                hintText: S.of(context).selectGender,
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 18),
                hintStyle: TextStyle(color: mediumGreyColor),
              ),
              dropDownButton: Icon(
                Icons.arrow_drop_down_rounded,
                color: mediumGreyColor,
              ),
            ).decorated(
              color: inputFieldColor,
              borderRadius: BorderRadius.circular(defaultBorderRadius),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: S.of(context).birthField,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
                hintStyle: TextStyle(color: mediumGreyColor),
                suffixIcon: Icon(Icons.calendar_today_rounded),
              ),
            ).decorated(
              color: inputFieldColor,
              borderRadius: BorderRadius.circular(defaultBorderRadius),
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
                hintText: S.of(context).selectProvince,
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 18),
                hintStyle: TextStyle(color: mediumGreyColor),
              ),
              dropDownButton: Icon(
                Icons.arrow_drop_down_rounded,
                color: mediumGreyColor,
              ),
            ).decorated(
              color: inputFieldColor,
              borderRadius: BorderRadius.circular(defaultBorderRadius),
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
                hintText: S.of(context).selectCity,
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 18),
                hintStyle: TextStyle(color: mediumGreyColor),
              ),
              dropDownButton: Icon(
                Icons.arrow_drop_down_rounded,
                color: mediumGreyColor,
              ),
            ).decorated(
              color: inputFieldColor,
              borderRadius: BorderRadius.circular(defaultBorderRadius),
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
                hintText: S.of(context).selectSubDistrict,
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 18),
                hintStyle: TextStyle(color: mediumGreyColor),
              ),
              dropDownButton: Icon(
                Icons.arrow_drop_down_rounded,
                color: mediumGreyColor,
              ),
            ).decorated(
              color: inputFieldColor,
              borderRadius: BorderRadius.circular(defaultBorderRadius),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: S.of(context).addressField,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
                hintStyle: TextStyle(color: mediumGreyColor),
              ),
            ).decorated(
              color: inputFieldColor,
              borderRadius: BorderRadius.circular(defaultBorderRadius),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: S.of(context).zipCodeField,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
                hintStyle: TextStyle(color: mediumGreyColor),
              ),
              keyboardType: TextInputType.number,
            ).decorated(
              color: inputFieldColor,
              borderRadius: BorderRadius.circular(defaultBorderRadius),
            ),
            SizedBox(height: 32),
            RoundedButton(
              onPressed: () {},
              label: S.of(context).save,
            ),
            SizedBox(height: 64),
          ],
        ),
      ).gestures(onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      }),
    );
  }
}

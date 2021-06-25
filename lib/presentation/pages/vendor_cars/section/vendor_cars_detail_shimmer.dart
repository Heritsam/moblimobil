import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../core/themes/theme.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/buttons/rounded_icon_button.dart';

class VendorCarsDetailShimmer extends StatelessWidget {
  const VendorCarsDetailShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

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
          S.of(context).carDetail,
          style: TextStyle(
            color: darkGreyColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RoundedIconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/vendor-cars-add');
                },
                icon: Icon(Icons.edit_outlined, color: Colors.white, size: 32),
                horizontalPadding: 24,
                verticalPadding: 20,
                backgroundColor: mediumGreyColor,
                enabled: false,
                elevated: false,
              ),
              SizedBox(height: 8),
              Text(
                'Edit',
                style: TextStyle(
                  color: mediumGreyColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(width: 16),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RoundedIconButton(
                icon: Icon(Icons.close, color: Colors.white, size: 32),
                horizontalPadding: 24,
                verticalPadding: 20,
                backgroundColor: redColor,
                enabled: false,
                elevated: false,
              ),
              SizedBox(height: 8),
              Text(
                'Delete',
                style: TextStyle(
                  color: mediumGreyColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(width: 16),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RoundedIconButton(
                icon: Icon(Icons.check, color: Colors.white, size: 32),
                horizontalPadding: 24,
                verticalPadding: 20,
                backgroundColor: greenColor,
                enabled: false,
                elevated: false,
              ),
              SizedBox(height: 8),
              Text(
                'Sold',
                style: TextStyle(
                  color: mediumGreyColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      )
          .parent(({required child}) => SafeArea(child: child))
          .padding(all: 16)
          .backgroundColor(Colors.white.withOpacity(.85))
          .backgroundBlur(7)
          .clipRRect(),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Shimmer.fromColors(
          baseColor: lightGreyColor,
          highlightColor: Colors.white24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: mediaQuery.padding.top + 56),
              Container(
                height: size.width - 40,
                width: size.width,
                color: lightGreyColor,
              ),
              SizedBox(height: 16),
              Container(
                height: 16,
                width: size.width / 2,
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: lightGreyColor,
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                ),
              ),
              SizedBox(height: 32),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 18,
                    width: size.width / 1.2,
                    decoration: BoxDecoration(
                      color: lightGreyColor,
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    height: 14,
                    width: size.width / 2,
                    decoration: BoxDecoration(
                      color: lightGreyColor,
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                    ),
                  ),
                ],
              ).padding(horizontal: 16),
            ],
          ),
        ),
      ),
    );
  }
}

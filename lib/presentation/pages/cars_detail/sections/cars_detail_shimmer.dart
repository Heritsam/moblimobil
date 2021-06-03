import 'package:flutter/material.dart';
import 'package:moblimobil/core/themes/mobli_icons_icons.dart';
import 'package:moblimobil/presentation/widgets/buttons/rounded_icon_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../core/themes/theme.dart';
import '../../../../generated/l10n.dart';

class CarsDetailShimmer extends StatelessWidget {
  const CarsDetailShimmer({Key? key}) : super(key: key);

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
        children: [
          RoundedIconButton(
            icon: Icon(MobliIcons.chat, color: mediumGreyColor),
            label: 'Chat Penjual',
            horizontalPadding: 0,
            enabled: false,
          ).expanded(),
          SizedBox(width: 16),
          RoundedIconButton(
            icon: Icon(Icons.phone_outlined, color: mediumGreyColor),
            label: 'Telepon',
            horizontalPadding: 0,
            backgroundColor: darkGreyColor,
            enabled: false,
          ).expanded(),
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
              Row(
                children: [
                  Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                      color: lightGreyColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    height: 16,
                    width: size.width / 2,
                    decoration: BoxDecoration(
                      color: lightGreyColor,
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                    ),
                  ),
                ],
              ).padding(horizontal: 16),
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

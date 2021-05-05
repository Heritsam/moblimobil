import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/theme.dart';
import '../../../generated/l10n.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white70,
        elevation: 0,
        centerTitle: false,
        title: Text(
          S.of(context).account,
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
          bottom: 32,
        ),
        child: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Styled.widget()
                      .decorated(
                        color: lightGreyColor,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://uifaces.co/our-content/donated/gPZwCbdS.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      )
                      .constrained(height: 120, width: 120)
                      .alignment(Alignment.center),
                  Icon(Icons.verified_user_rounded, color: greenColor, size: 18)
                      .padding(all: 4)
                      .decorated(color: Colors.white, shape: BoxShape.circle)
                      .elevation(
                        10,
                        borderRadius: BorderRadius.circular(150),
                        shadowColor: Colors.black38,
                      )
                      .alignment(Alignment.topRight)
                      .padding(top: 4, right: 4),
                ],
              ).constrained(height: 120, width: 120),
              SizedBox(height: 16),
              Text(
                'Rohayat G. Ade',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: darkGreyColor,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                '0812 3456 7890',
                style: TextStyle(
                  color: greenColor,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 16),
              Text(
                S.of(context).emailVerificationMessage,
                style: TextStyle(color: redColor, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          )
              .padding(all: 32)
              .decorated(
                color: Colors.white,
                borderRadius: BorderRadius.circular(defaultBorderRadius),
              )
              .elevation(
                10,
                borderRadius: BorderRadius.circular(defaultBorderRadius),
                shadowColor: Colors.black38,
              )
              .padding(horizontal: 16)
              .width(size.width),
          SizedBox(height: 24),
          _item(
            onTap: () {
              Navigator.pushNamed(context, '/wishlist');
            },
            context: context,
            icon: Icons.favorite_border_rounded,
            title: S.of(context).wishlist,
          ),
          _item(
            onTap: () {
              Navigator.pushNamed(context, '/edit-profile');
            },
            context: context,
            icon: Icons.person_outline_rounded,
            title: S.of(context).editProfile,
          ),
          _item(
            onTap: () {
              Navigator.pushNamed(context, '/help');
            },
            context: context,
            icon: Icons.help_outline_rounded,
            title: S.of(context).help,
          ),
          _item(
            onTap: () {
              Navigator.pushNamed(context, '/about');
            },
            context: context,
            icon: Icons.info_outline_rounded,
            title: S.of(context).about,
          ),
          _item(
            onTap: () {
              Navigator.pushNamed(context, '/change-password');
            },
            context: context,
            icon: Icons.vpn_key_outlined,
            title: S.of(context).changePhoneAndPassword,
          ),
          SizedBox(height: 24),
        ].toColumn(mainAxisAlignment: MainAxisAlignment.center),
      ),
    );
  }

  Widget _item({
    required BuildContext context,
    required IconData icon,
    required String title,
    Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: <Widget>[
        <Widget>[
          Icon(icon, color: mediumGreyColor, size: 28),
          SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(fontSize: 16, color: darkGreyColor),
          ).expanded(),
        ].toRow().expanded(flex: 3),
      ].toRow().padding(all: 16),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moblimobil/presentation/widgets/dialog/custom_dialog.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/theme.dart';
import '../../../generated/l10n.dart';
import '../../notifiers/app_settings/app_settings_notifier.dart';
import '../buttons/circle_button.dart';
import '../toggle.dart';
import 'user_card.dart';

class MobliDrawer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final settings = watch(appSettingsNotifier);
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    return Drawer(
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white70,
          elevation: 0,
          centerTitle: false,
          flexibleSpace: ClipRRect(
            child: Container(color: Colors.white60).backgroundBlur(5),
          ),
          title: Text(
            'Menu',
            style: textTheme.headline6?.copyWith(color: darkGreyColor),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: darkGreyColor,
              icon: Icon(Icons.arrow_right_alt_rounded),
            ),
          ],
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            _drawerItem(
              context: context,
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName('/home'));
              },
              title: S.of(context).home.toUpperCase(),
              icon: Icons.home_outlined,
            ),
            _drawerItem(
              context: context,
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName('/home'));
                Navigator.pushNamed(context, '/new-cars');
              },
              title: S.of(context).newCars.toUpperCase(),
              icon: Icons.directions_car_outlined,
            ),
            _drawerItem(
              context: context,
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName('/home'));
                Navigator.pushNamed(context, '/used-cars');
              },
              title: S.of(context).usedCars.toUpperCase(),
              icon: Icons.directions_car_outlined,
            ),
            _drawerItem(
              context: context,
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName('/home'));
                Navigator.pushNamed(context, '/discount');
              },
              title: S.of(context).discountAndPromo.toUpperCase(),
              icon: Icons.account_balance_wallet_outlined,
            ),
            _drawerItem(
              context: context,
              title: S.of(context).insurance.toUpperCase(),
              icon: Icons.verified_user_outlined,
              trailing: Icon(Icons.lock, color: mediumGreyColor),
            ),
            _drawerItem(
              context: context,
              title: S.of(context).credit.toUpperCase(),
              icon: Icons.attach_money_outlined,
              trailing: Icon(Icons.lock, color: mediumGreyColor),
            ),
            _drawerItem(
              context: context,
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName('/home'));
                Navigator.pushNamed(context, '/news-and-review');
              },
              title: S.of(context).newsAndReview.toUpperCase(),
              icon: Icons.article_outlined,
            ),
            _drawerItem(
              context: context,
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName('/home'));
                Navigator.pushNamed(context, '/faq');
              },
              title: 'FAQ',
              icon: Icons.chat_outlined,
            ),
            _drawerItem(
              context: context,
              title: S.of(context).language.toUpperCase(),
              icon: Icons.language_outlined,
              trailing: Toggle(
                onTap: (value) {
                  context
                      .read(appSettingsNotifier)
                      .changeLanguage(value.toLowerCase());
                },
                items: ['EN', 'ID'],
                value: settings.language.toUpperCase(),
              ).expanded(flex: 2),
            ),
            CircleButton(
              onPressed: () {
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CustomDialog(
                    title: S.of(context).logout,
                    description: S.of(context).logoutMessage,
                    actions: [
                      CustomDialogAction(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        label: S.of(context).no,
                        isDefaultAction: true,
                      ),
                      CustomDialogAction(
                        onPressed: () {
                          Navigator.popUntil(context, ModalRoute.withName('/home'));
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        label: S.of(context).yes,
                        isDestructiveAction: true,
                      ),
                    ],
                  ),
                );
              },
              child: Icon(Icons.exit_to_app, color: redColor, size: 32),
            ).center(),
            SizedBox(height: 12),
            Text(
              S.of(context).logout,
              style: TextStyle(color: mediumGreyColor),
            ).center(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    Widget? trailing,
    Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: <Widget>[
        <Widget>[
          Icon(icon, color: darkGreyColor),
          SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(fontSize: 16, color: darkGreyColor),
          ),
        ].toRow().expanded(flex: 3),
        SizedBox(width: 16),
        trailing ?? SizedBox(),
      ].toRow().padding(all: 16),
    );
  }

  Widget _divider(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Styled.widget()
        .decorated(color: mediumGreyColor)
        .constrained(width: size.width, height: 1)
        .padding(horizontal: 16);
  }
}

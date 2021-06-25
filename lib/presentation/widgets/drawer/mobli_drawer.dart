import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/mobli_icons_icons.dart';
import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../notifiers/app_settings/app_settings_notifier.dart';
import '../../notifiers/authentication/authentication_notifier.dart';
import '../../pages/account/viewmodels/account_user_notifier.dart';
import '../dialog/custom_dialog.dart';
import '../toggle.dart';

class MobliDrawer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final settings = watch(appSettingsNotifier);
    final userNotifier = watch(accountUserNotifier);

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
            style: TextStyle(color: darkGreyColor, fontWeight: FontWeight.w600),
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
              title: S.of(context).discountAndPromo.toUpperCase(),
              icon: MobliIcons.discount,
            ),
            _drawerItem(
              context: context,
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName('/home'));
                Navigator.pushNamed(context, '/faq');
              },
              title: 'FAQ',
              icon: MobliIcons.faq,
            ),
            _drawerItem(
              context: context,
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName('/home'));
                Navigator.pushNamed(context, '/help');
              },
              title: S.of(context).help.toUpperCase(),
              icon: Icons.help_outline_rounded,
            ),
            _drawerItem(
              context: context,
              title: S.of(context).contributor.toUpperCase(),
              icon: MobliIcons.edit,
              trailing: Icon(Icons.lock, color: mediumGreyColor),
            ),
            _drawerItem(
              context: context,
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName('/home'));
                userNotifier.userState.maybeWhen(
                  data: (user) {
                    if (user.statusVendor == 'active') {
                      Navigator.pushNamed(context, '/vendor-cars-add');
                    } else {
                      Navigator.pushNamed(context, '/vendor-register');
                    }
                  },
                  orElse: () {},
                );
              },
              title: S.of(context).sellCar.toUpperCase(),
              icon: MobliIcons.car,
            ),
            _drawerItem(
              context: context,
              title: S.of(context).advertisement.toUpperCase(),
              icon: MobliIcons.advertisement,
              trailing: Icon(Icons.lock, color: mediumGreyColor),
            ),
            _drawerItem(
              context: context,
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName('/home'));
                Navigator.pushNamed(context, '/about');
              },
              title: S.of(context).aboutUs.toUpperCase(),
              icon: Icons.info_outline,
            ),
            _drawerItem(
              context: context,
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName('/home'));
                Navigator.pushNamed(context, '/change-password');
              },
              title: S.of(context).changePassword.toUpperCase(),
              icon: MobliIcons.key,
            ),
            _drawerItem(
              context: context,
              onTap: () {
                Navigator.popUntil(context, ModalRoute.withName('/home'));
                Navigator.pushNamed(context, '/edit-profile');
              },
              title: S.of(context).editProfile.toUpperCase(),
              icon: MobliIcons.edit,
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
                radius: 150,
              ).expanded(flex: 2),
            ),
            _drawerItem(
              context: context,
              onTap: () {
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
                          context
                              .read(authenticationNotifier.notifier)
                              .logout();
                          Navigator.popUntil(
                              context, ModalRoute.withName('/home'));
                        },
                        label: S.of(context).yes,
                        isDestructiveAction: true,
                      ),
                    ],
                  ),
                );
              },
              title: S.of(context).logout.toUpperCase(),
              icon: MobliIcons.logout,
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem({
    required BuildContext context,
    required IconData icon,
    double iconSize = 20,
    required String title,
    Widget? trailing,
    Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: <Widget>[
        <Widget>[
          Icon(icon, color: darkGreyColor, size: iconSize),
          SizedBox(width: 24),
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ).expanded(),
        ].toRow().expanded(flex: 3),
        SizedBox(width: 16),
        trailing ?? SizedBox(),
      ].toRow().padding(all: 16),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../core/theme.dart';
import '../../generated/l10n.dart';
import '../notifiers/app_settings/app_settings_notifier.dart';

class MobliDrawer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final settings = watch(appSettingsNotifier);
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

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
            style: textTheme.headline6?.copyWith(color: blackColor),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: blackColor,
              icon: Icon(Icons.arrow_right_alt_rounded),
            ),
          ],
        ),
        body: ListView(
          children: [
            InkWell(
              onTap: () {},
              child: <Widget>[
                Icon(Icons.home_outlined),
                SizedBox(width: 16),
                Text(
                  S.of(context).home.toUpperCase(),
                  style: TextStyle(fontSize: 18),
                ),
              ].toRow().padding(all: 16),
            ),
            Styled.widget()
                .decorated(color: mediumGreyColor)
                .constrained(width: size.width, height: 1),
            InkWell(
              onTap: () {},
              child: <Widget>[
                Icon(Icons.directions_car_outlined),
                SizedBox(width: 16),
                Text(
                  S.of(context).newCars.toUpperCase(),
                  style: TextStyle(fontSize: 18),
                ),
              ].toRow().padding(all: 16),
            ),
            Styled.widget()
                .decorated(color: mediumGreyColor)
                .constrained(width: size.width, height: 1),
            InkWell(
              onTap: () {},
              child: <Widget>[
                Icon(Icons.directions_car_outlined),
                SizedBox(width: 16),
                Text(
                  S.of(context).usedCars.toUpperCase(),
                  style: TextStyle(fontSize: 18),
                ),
              ].toRow().padding(all: 16),
            ),
            Styled.widget()
                .decorated(color: mediumGreyColor)
                .constrained(width: size.width, height: 1),
            InkWell(
              onTap: () {},
              child: <Widget>[
                Icon(Icons.account_balance_wallet_outlined),
                SizedBox(width: 16),
                Text(
                  S.of(context).discountAndPromo.toUpperCase(),
                  style: TextStyle(fontSize: 18),
                ),
              ].toRow().padding(all: 16),
            ),
            Styled.widget()
                .decorated(color: mediumGreyColor)
                .constrained(width: size.width, height: 1),
            InkWell(
              onTap: () {},
              child: <Widget>[
                Icon(Icons.verified_user_outlined),
                SizedBox(width: 16),
                Text(
                  S.of(context).insurance.toUpperCase(),
                  style: TextStyle(fontSize: 18),
                ),
              ].toRow().padding(all: 16),
            ),
            Styled.widget()
                .decorated(color: mediumGreyColor)
                .constrained(width: size.width, height: 1),
            InkWell(
              onTap: () {},
              child: <Widget>[
                Icon(Icons.attach_money_outlined),
                SizedBox(width: 16),
                Text(
                  S.of(context).credit.toUpperCase(),
                  style: TextStyle(fontSize: 18),
                ),
              ].toRow().padding(all: 16),
            ),
            Styled.widget()
                .decorated(color: mediumGreyColor)
                .constrained(width: size.width, height: 1),
            InkWell(
              onTap: () {},
              child: <Widget>[
                Icon(Icons.article_outlined),
                SizedBox(width: 16),
                Text(
                  S.of(context).newsAndReview.toUpperCase(),
                  style: TextStyle(fontSize: 18),
                ),
              ].toRow().padding(all: 16),
            ),
            Styled.widget()
                .decorated(color: mediumGreyColor)
                .constrained(width: size.width, height: 1),
            InkWell(
              onTap: () {},
              child: <Widget>[
                Icon(Icons.chat_outlined),
                SizedBox(width: 16),
                Text(
                  'faq'.toUpperCase(),
                  style: TextStyle(fontSize: 18),
                ),
              ].toRow().padding(all: 16),
            ),
            Styled.widget()
                .decorated(color: mediumGreyColor)
                .constrained(width: size.width, height: 1),
            InkWell(
              onTap: () {},
              child: <Widget>[
                Icon(Icons.person_outline_rounded),
                SizedBox(width: 16),
                Text(
                  S.of(context).account.toUpperCase(),
                  style: TextStyle(fontSize: 18),
                ),
              ].toRow().padding(all: 16),
            ),
            Styled.widget()
                .decorated(color: mediumGreyColor)
                .constrained(width: size.width, height: 1),
            <Widget>[
              Icon(Icons.language_outlined),
              SizedBox(width: 16),
              Text(
                S.of(context).language.toUpperCase(),
                style: TextStyle(fontSize: 18),
              ),
              Expanded(
                child: <Widget>[
                  InkResponse(
                    onTap: () {
                      context.read(appSettingsNotifier).changeLanguage('en');
                    },
                    child: Text(
                      'EN',
                      style: TextStyle(
                        fontSize: 16,
                        color:
                            settings.language == 'en' ? blueColor : blackColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    '/',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 4),
                  InkResponse(
                    onTap: () {
                      context.read(appSettingsNotifier).changeLanguage('id');
                    },
                    child: Text(
                      'ID',
                      style: TextStyle(
                        fontSize: 16,
                        color:
                            settings.language == 'id' ? blueColor : blackColor,
                      ),
                    ),
                  ),
                ].toRow(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              ),
            ].toRow().padding(all: 16),
            Styled.widget()
                .decorated(color: mediumGreyColor)
                .constrained(width: size.width, height: 1),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: Text(S.of(context).logout),
                    content: Text(S.of(context).logoutMessage),
                    actions: [
                      CupertinoDialogAction(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(S.of(context).no),
                        isDefaultAction: true,
                      ),
                      CupertinoDialogAction(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Text(S.of(context).yes),
                        isDestructiveAction: true,
                      ),
                    ],
                  ),
                );
              },
              child: <Widget>[
                Icon(Icons.exit_to_app_outlined),
                SizedBox(width: 16),
                Text(
                  S.of(context).logout.toUpperCase(),
                  style: TextStyle(fontSize: 18),
                ),
              ].toRow().padding(all: 16),
            ),
            Styled.widget()
                .decorated(color: mediumGreyColor)
                .constrained(width: size.width, height: 1),
          ],
        ),
      ),
    );
  }
}

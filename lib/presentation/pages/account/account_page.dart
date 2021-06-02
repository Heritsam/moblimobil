import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/mobli_icons_icons.dart';
import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../notifiers/authentication/authentication_notifier.dart';
import '../../widgets/error/empty_state.dart';
import 'tabs/account_user.dart';
import 'tabs/account_vendor.dart';
import 'viewmodels/account_user_notifier.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderListener(
      provider: authenticationNotifier,
      onChange: (context, AuthenticationState state) {
        state.maybeWhen(
          authenticated: () {
            context.read(accountUserNotifier).fetchUser();
          },
          orElse: () {},
        );
      },
      child: Consumer(
        builder: (context, watch, child) {
          final authState = watch(authenticationNotifier);
          final userState = watch(accountUserNotifier);

          return authState.when(
            unauthenticated: () {
              return EmptyState(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                message: S.of(context).loginToContinue,
                buttonLabel: 'Login',
              );
            },
            authenticated: () {
              return DefaultTabController(
                length: 2,
                child: Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Colors.white70,
                    elevation: 0,
                    centerTitle: false,
                    title: Text(
                      S.of(context).profile,
                      style: TextStyle(
                          color: darkGreyColor, fontWeight: FontWeight.w700),
                    ),
                    flexibleSpace: ClipRRect(
                      child: Container(color: Colors.white60).backgroundBlur(7),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          Scaffold.of(context).openEndDrawer();
                        },
                        icon: Icon(MobliIcons.menu),
                      ),
                    ],
                    bottom: PreferredSize(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            height: 1,
                            color: lightGreyColor,
                            margin: EdgeInsets.only(bottom: .5),
                          ),
                          TabBar(
                            indicatorColor: blueColor,
                            labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w700,
                            ),
                            labelColor: blueColor,
                            unselectedLabelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                            ),
                            unselectedLabelColor: darkGreyColor,
                            tabs: [
                              Tab(text: 'User'),
                              Tab(text: 'Vendor'),
                            ],
                          ),
                        ],
                      ),
                      preferredSize: Size.fromHeight(48),
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      AccountUser(),
                      AccountVendor(),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

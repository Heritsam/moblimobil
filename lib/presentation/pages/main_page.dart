import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uni_links/uni_links.dart';

import '../../core/themes/mobli_icons_icons.dart';
import '../../generated/l10n.dart';
import '../notifiers/authentication/authentication_notifier.dart';
import '../notifiers/bottom_nav/bottom_nav_notifier.dart';
import '../notifiers/deeplink_notifier/deeplink_notifier.dart';
import '../widgets/drawer/mobli_drawer.dart';
import 'account/account_page.dart';
import 'cars/cars_page.dart';
import 'home/home_page.dart';
import 'news/news_and_review_page.dart';
import 'search/search_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      context.read(authenticationNotifier.notifier).checkStatus();
      final initialLink = await getInitialLink();

      if (initialLink != null) {
        return context
            .read(deeplinkNotifier)
            .handleDeeplinks(context, initialLink);
      }
    });

    // listen to changes on deeplink
    _sub = uriLinkStream.listen(
      (link) {
        if (link != null) {
          context
              .read(deeplinkNotifier)
              .handleDeeplinks(context, link.toString());
        }
      },
      onError: (err) {
        print('deeplink error $err');
      },
    );
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        final state = watch(bottomNavNotifier);

        return Scaffold(
          key: _scaffoldKey,
          extendBody: true,
          body: ProviderListener(
            provider: authenticationNotifier,
            onChange: (context, AuthenticationState state) async {
              state.maybeWhen(
                unauthenticated: () async {
                  await Future.delayed(Duration(seconds: 1));
                  Navigator.pushNamed(context, '/onboarding');
                },
                orElse: () {},
              );
            },
            child: PageView(
              controller: state.controller,
              physics: NeverScrollableScrollPhysics(),
              children: [
                HomePage(),
                SearchPage(),
                NewsAndReviewPage(),
                CarsPage(),
                AccountPage(),
              ],
            ),
          ),
          resizeToAvoidBottomInset: false,
          endDrawerEnableOpenDragGesture: false,
          endDrawer: state.index == 4
              ? Consumer(
                  builder: (context, watch, child) {
                    final authState = watch(authenticationNotifier);

                    return authState.when(
                      unauthenticated: () => Container(),
                      authenticated: () => MobliDrawer(),
                    );
                  },
                )
              : null,
          bottomNavigationBar: CupertinoTabBar(
            onTap: (index) {
              state.changeIndex(index);
            },
            currentIndex: state.index,
            backgroundColor: Colors.white.withOpacity(.85),
            border: Border(),
            items: [
              BottomNavigationBarItem(
                icon: Icon(MobliIcons.home),
                label: S.of(context).home,
              ),
              BottomNavigationBarItem(
                icon: Icon(MobliIcons.explore),
                label: S.of(context).explore,
              ),
              BottomNavigationBarItem(
                icon: Icon(MobliIcons.car),
                label: S.of(context).newsAndReview,
              ),
              BottomNavigationBarItem(
                icon: Icon(MobliIcons.compare),
                label: S.of(context).compare,
              ),
              BottomNavigationBarItem(
                icon: Icon(MobliIcons.profile),
                label: S.of(context).profile,
              ),
            ],
          ),
        );
      },
    );
  }
}

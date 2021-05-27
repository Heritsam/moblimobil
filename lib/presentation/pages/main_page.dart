import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/themes/mobli_icons_icons.dart';
import '../../generated/l10n.dart';
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
  final _controller = PageController();

  int _pageIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomePage(),
          SearchPage(),
          NewsAndReviewPage(),
          CarsPage(type: CarsPageType.compare),
          AccountPage(),
        ],
      ),
      endDrawer: _pageIndex == 4 ? MobliDrawer() : null,
      bottomNavigationBar: CupertinoTabBar(
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _pageIndex = index;
          });
        },
        currentIndex: _pageIndex,
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
  }
}
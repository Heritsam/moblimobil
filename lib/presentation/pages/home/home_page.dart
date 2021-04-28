import 'dart:math' as math;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/theme.dart';
import '../../../generated/l10n.dart';
import '../../widgets/mobli_drawer.dart';
import 'notifiers/home_banner_notifier.dart';
import 'widgets/car_card.dart';
import 'widgets/menu_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        centerTitle: false,
        elevation: 0,
        title: Text('MobliMobil',
            style: textTheme.headline6?.copyWith(color: blackColor)),
        flexibleSpace: ClipRRect(
          child: Container(color: Colors.white60).backgroundBlur(7),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none_rounded),
            color: blackColor,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search_rounded),
            color: blackColor,
          ),
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
            icon: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: Icon(Icons.short_text_rounded),
            ),
            color: blackColor,
          ),
        ],
      ),
      endDrawer: MobliDrawer(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: <Widget>[
          SizedBox(height: 56 + mediaQuery.padding.top),
          Consumer(
            builder: (context, watch, child) {
              final state = watch(homeBannerNotifier);

              return <Widget>[
                CarouselSlider(
                  options: CarouselOptions(
                    initialPage: state.index,
                    height: 160,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      context.read(homeBannerNotifier).indexChanged(index);
                    },
                  ),
                  items: state.items.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          height: 160,
                          width: size.width,
                          decoration: BoxDecoration(
                            color: blueColor,
                            image: DecorationImage(
                              image: AssetImage(i),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ).clipRRect(all: defaultBorderRadius).padding(all: 16),
                AnimatedSmoothIndicator(
                  activeIndex: state.index,
                  count: state.items.length,
                  effect: WormEffect(
                    activeDotColor: blueColor,
                    dotColor: lightGreyColor,
                    dotHeight: 8,
                    dotWidth: 8,
                  ),
                ).padding(bottom: 24),
              ].toStack(alignment: Alignment.bottomCenter);
            },
          ),
          <Widget>[
            Expanded(
              child: MenuItem(
                icon: SvgPicture.asset('assets/ic_new_cars.svg'),
                label: S.of(context).newCars,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: MenuItem(
                icon: SvgPicture.asset('assets/ic_used_cars.svg'),
                label: S.of(context).usedCars,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: MenuItem(
                icon: SvgPicture.asset('assets/ic_compare.svg'),
                label: S.of(context).compare,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: MenuItem(
                icon: SvgPicture.asset('assets/ic_news.svg'),
                label: S.of(context).newsAndReview,
              ),
            ),
          ]
              .toRow(crossAxisAlignment: CrossAxisAlignment.start)
              .padding(horizontal: 16, top: 8),
          SizedBox(height: 32),
          <Widget>[
            Text(S.of(context).hotDeals, style: textTheme.headline6),
            InkResponse(
              onTap: () {},
              child: Text(
                S.of(context).seeAll,
                style: TextStyle(color: blueColor),
              ),
            ),
          ]
              .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
              .padding(horizontal: 16),
          SizedBox(height: 16),
          ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: 6,
            itemBuilder: (context, index) {
              return CarCard(
                title: 'Toyota Supra',
                subtitle: 'Lorem ipsum is simply dummy text of the printing',
                hasUsed: index % 2 == 0,
                imageUrl:
                    'https://images.unsplash.com/photo-1613946990583-5ffd41268b72?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80',
              ).padding(right: 16);
            },
          ).constrained(height: 200),
          SizedBox(height: 32),
          <Widget>[
            Text(S.of(context).popularCars, style: textTheme.headline6),
            InkResponse(
              onTap: () {},
              child: Text(
                S.of(context).seeAll,
                style: TextStyle(color: blueColor),
              ),
            ),
          ]
              .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
              .padding(horizontal: 16),
          SizedBox(height: 16),
          ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: 6,
            itemBuilder: (context, index) {
              return CarCard(
                title: 'Rolls Royce',
                subtitle: 'Lorem ipsum is simply dummy text of the printing',
                imageUrl:
                    'https://images.unsplash.com/photo-1612538790197-61ccec68d648?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80',
              ).padding(right: 16);
            },
          ).constrained(height: 200),
          SizedBox(height: 32),
          <Widget>[
            Text(S.of(context).price, style: textTheme.headline6),
            InkResponse(
              onTap: () {},
              child: Text(
                S.of(context).seeAll,
                style: TextStyle(color: blueColor),
              ),
            ),
          ]
              .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
              .padding(horizontal: 16),
          SizedBox(height: 12),
          ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Styled.widget(
                child: Chip(
                  label: Text('100jt-300jt'),
                  padding: EdgeInsets.all(8),
                ),
              ).padding(right: 8);
            },
          ).constrained(height: 40),
          SizedBox(height: 12),
          ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: 6,
            itemBuilder: (context, index) {
              return CarCard(
                title: 'Chevrolet Camaro',
                subtitle: 'Lorem ipsum is simply dummy text of the printing',
                imageUrl:
                    'https://images.unsplash.com/photo-1597075945661-b6348139021a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80',
              ).padding(right: 16);
            },
          ).constrained(height: 200),
          SizedBox(height: 32),
          <Widget>[
            Text(S.of(context).searchByLocation, style: textTheme.headline6),
          ]
              .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
              .padding(horizontal: 16),
          SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 12,
            children: [
              'Jakarta',
              'Tangerang',
              'Bogor',
              'Bekasi',
              'Depok',
              'Sukabumi',
              'Bandung',
              'Seattle',
            ].map((e) {
              return Styled.text(e, textAlign: TextAlign.center)
                  .fittedBox()
                  .center()
                  .decorated(
                    color: lightGreyColor,
                    borderRadius: BorderRadius.circular(defaultBorderRadius),
                  )
                  .constrained(height: 32, width: size.width / 4 - 16);
            }).toList(),
          ).padding(horizontal: 16),
          SizedBox(height: 64),
        ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
      ),
    );
  }
}

import 'dart:math' as math;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/theme.dart';
import '../../../generated/l10n.dart';
import '../../widgets/drawer/mobli_drawer.dart';
import 'notifiers/home_banner_notifier.dart';
import 'widgets/brand_item.dart';
import 'widgets/car_card.dart';
import 'widgets/location_chip.dart';
import 'widgets/menu_item.dart';
import 'widgets/price_chip.dart';
import 'widgets/video_card.dart';

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        elevation: 0,
        title: SvgPicture.asset('assets/logo.svg', height: 32, width: 32),
        flexibleSpace:
            Container(color: lightBlueColor).backgroundBlur(7).clipRRect(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/notification');
            },
            icon: Icon(Icons.notifications_none_rounded),
            color: greenColor,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search_rounded),
            color: greenColor,
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
            color: greenColor,
          ),
        ],
      ),
      endDrawer: MobliDrawer(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: <Widget>[
          Transform(
            transform: Matrix4.rotationY(math.pi),
            alignment: Alignment.center,
            child: Container(
              transform: Matrix4.rotationX(math.pi),
              transformAlignment: Alignment.center,
              alignment: Alignment.topCenter,
              height: size.height / 2.2,
              width: size.width * 3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bg_wave.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          <Widget>[
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
                  )
                      .clipRRect(all: defaultBorderRadius)
                      .elevation(
                        10,
                        borderRadius:
                            BorderRadius.circular(defaultBorderRadius),
                        shadowColor: Colors.black38,
                      )
                      .padding(all: 16),
                  AnimatedSmoothIndicator(
                    activeIndex: state.index,
                    count: state.items.length,
                    effect: WormEffect(
                      activeDotColor: blueColor,
                      dotColor: lightGreyColor,
                      dotHeight: 8,
                      dotWidth: 8,
                    ),
                  ),
                ].toStack(alignment: Alignment.bottomCenter);
              },
            ),
            SizedBox(height: 16),
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
                  style: TextStyle(color: greenColor),
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
                  originalPrice: 750000000,
                  price: 650000000,
                  hasUsed: index.isEven,
                  imageUrl:
                      'https://images.unsplash.com/photo-1613946990583-5ffd41268b72?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80',
                ).padding(right: 16, bottom: 32);
              },
            ).constrained(height: 240),
            <Widget>[
              Text(S.of(context).popularCars, style: textTheme.headline6),
              InkResponse(
                onTap: () {},
                child: Text(
                  S.of(context).seeAll,
                  style: TextStyle(color: greenColor),
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
                  price: 1650000000,
                  hasUsed: index.isOdd,
                  imageUrl:
                      'https://images.unsplash.com/photo-1612538790197-61ccec68d648?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80',
                ).padding(right: 16, bottom: 32);
              },
            ).constrained(height: 240),
            <Widget>[
              Text(S.of(context).price, style: textTheme.headline6),
              InkResponse(
                onTap: () {},
                child: Text(
                  S.of(context).seeAll,
                  style: TextStyle(color: greenColor),
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
                return PriceChip(
                  label: '100 jt - 300 jt',
                  selected: index == 0,
                ).padding(right: 16, bottom: 16);
              },
            ).constrained(height: 64),
            ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: 6,
              itemBuilder: (context, index) {
                return CarCard(
                  title: 'Chevrolet Camaro',
                  price: 1250000000,
                  hasUsed: index.isEven,
                  imageUrl:
                      'https://images.unsplash.com/photo-1597075945661-b6348139021a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80',
                ).padding(right: 16, bottom: 32);
              },
            ).constrained(height: 240),
            <Widget>[
              Text(S.of(context).searchByLocation, style: textTheme.headline6),
            ]
                .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
                .padding(horizontal: 16),
            SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 12,
              children: [
                'Jakarta',
                'Tangerang',
                'Bogor',
                'Depok',
                'Bandung',
                'Detroit',
              ].map((e) {
                return LocationChip(
                  label: e,
                ).constrained(height: 40, width: size.width / 3 - 18);
              }).toList(),
            ).padding(horizontal: 16),
            SizedBox(height: 32),
            <Widget>[
              Text(S.of(context).searchByBrand, style: textTheme.headline6)
                  .expanded(),
              InkResponse(
                onTap: () {},
                child: Text(
                  S.of(context).seeAll,
                  style: TextStyle(color: greenColor),
                ),
              ),
            ]
                .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
                .padding(horizontal: 16),
            SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 12,
              children: [
                'assets/brands/toyota.png',
                'assets/brands/bmw.png',
                'assets/brands/suzuki.png',
                'assets/brands/honda.png',
                'assets/brands/nissan.png',
                'assets/brands/daihatsu.png',
                'assets/brands/mitsubishi.png',
                'assets/brands/datsun.png',
              ].map((e) {
                return BrandItem(
                  onTap: () {},
                  image: AssetImage(e),
                );
              }).toList(),
            ).padding(horizontal: 16),
            SizedBox(height: 32),
            <Widget>[
              Text(S.of(context).videos, style: textTheme.headline6),
              InkResponse(
                onTap: () {},
                child: Text(
                  S.of(context).seeAll,
                  style: TextStyle(color: greenColor),
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
                return VideoCard(
                  thumbnail: AssetImage('assets/thumbnail.jpg'),
                  title:
                      'SERIUS TONTON‼️JOKOWI TIGA PERIODE IS NO JOKES‼️- Deddy Corbuzier Podcast',
                ).padding(right: 16, bottom: 32);
              },
            ).constrained(height: 210),
            SizedBox(height: 64),
          ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
        ].toStack(),
      ),
    );
  }
}

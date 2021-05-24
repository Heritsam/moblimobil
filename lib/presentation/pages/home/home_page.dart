import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructures/models/car.dart';
import '../../widgets/cars/brand_item.dart';
import '../../widgets/cars/car_card.dart';
import '../../widgets/cars/location_chip.dart';
import '../../widgets/cars/menu_item.dart';
import '../../widgets/cars/price_chip.dart';
import '../../widgets/video/video_card.dart';
import 'viewmodels/home_banner_notifier.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        centerTitle: false,
        elevation: 0,
        title: Text(
          'LakuMobil',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
        flexibleSpace: ClipRRect(
          child: Container(color: Colors.white60).backgroundBlur(7),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/notification');
            },
            icon: Badge(
              badgeContent: Text('1').textColor(Colors.white),
              badgeColor: redColor,
              child: Icon(Icons.notifications_none_rounded),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.chat_bubble_outline_rounded),
          ),
        ],
      ),
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
                )
                    .clipRRect(all: defaultBorderRadius)
                    .elevation(
                      10,
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                      shadowColor: Colors.black38,
                    )
                    .padding(all: 16),
                AnimatedSmoothIndicator(
                  activeIndex: state.index,
                  count: state.items.length,
                  effect: WormEffect(
                    activeDotColor: blueColor,
                    dotColor: lightGreyColor.withOpacity(.24),
                    dotHeight: 8,
                    dotWidth: 8,
                  ),
                ).padding(bottom: 28),
              ].toStack(alignment: Alignment.bottomCenter);
            },
          ),
          <Widget>[
            Expanded(
              child: MenuItem(
                icon: Image.asset('assets/feature_1.png'),
                label: 'Garansi 1 Tahun',
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: MenuItem(
                icon: Image.asset('assets/feature_2.png'),
                label: 'Tersertifikasi',
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: MenuItem(
                icon: Image.asset('assets/feature_3.png'),
                label: 'Garansi Uang Kembali',
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
            itemCount: carList.length,
            itemBuilder: (context, index) {
              final item = carList[index];

              return CarCard(
                onTap: () {
                  Navigator.pushNamed(context, '/cars-detail');
                },
                carId: item.id,
                title: item.title,
                price: item.price,
                hasUsed: index.isEven,
                imageUrl: item.imageUrl,
              ).padding(right: 16, bottom: 32);
            },
          ).constrained(height: 240),
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
            itemCount: carList.length,
            itemBuilder: (context, index) {
              final item = carList[index];

              return CarCard(
                onTap: () {
                  Navigator.pushNamed(context, '/cars-detail');
                },
                carId: item.id,
                title: item.title,
                price: item.price,
                hasUsed: index.isEven,
                imageUrl: item.imageUrl,
              ).padding(right: 16, bottom: 32);
            },
          ).constrained(height: 240),
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
            itemCount: carList.length,
            itemBuilder: (context, index) {
              final item = carList[index];

              return CarCard(
                onTap: () {
                  Navigator.pushNamed(context, '/cars-detail');
                },
                carId: item.id,
                title: item.title,
                price: item.price,
                hasUsed: index.isEven,
                imageUrl: item.imageUrl,
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
            runSpacing: 14,
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
              ).constrained(height: 44, width: size.width / 3 - 18);
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
                style: TextStyle(color: blueColor),
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
          Row(
            children: [
              Text(S.of(context).videos, style: textTheme.headline6),
              InkResponse(
                onTap: () {
                  Navigator.pushNamed(context, '/videos');
                },
                child: Text(
                  S.of(context).seeAll,
                  style: TextStyle(color: blueColor),
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ).padding(horizontal: 16),
          SizedBox(height: 16),
          ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemCount: 6,
            itemBuilder: (context, index) {
              return VideoCard(
                thumbnail: AssetImage('assets/thumbnail.jpg'),
                title: 'BTS 100 JUTA CHALLENGE: CHALLENGE OFF-ROAD',
              ).padding(right: 16, bottom: 24);
            },
          ).constrained(height: 210),
          SizedBox(height: 32 + mediaQuery.padding.bottom),
        ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructures/models/car.dart';
import '../../notifiers/app_settings/app_settings_notifier.dart';
import '../../widgets/buttons/rounded_button.dart';
import '../../widgets/buttons/whatsapp_button.dart';
import '../../widgets/cars/brand_item.dart';
import '../../widgets/cars/car_card.dart';
import '../../widgets/cars/feature_item.dart';
import 'credit_simulation.dart';
import 'test_drive.dart';

class CarsDetailPage extends StatefulWidget {
  @override
  _CarsDetailPageState createState() => _CarsDetailPageState();
}

class _CarsDetailPageState extends State<CarsDetailPage> {
  int _sliderIndex = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
        centerTitle: false,
        flexibleSpace: ClipRRect(
          child: Container(color: Colors.white60).backgroundBlur(7),
        ),
        title: Text(
          S.of(context).carDetail,
          style: textTheme.headline6?.copyWith(color: darkGreyColor),
        ),
      ),
      body: Consumer(
        builder: (context, watch, child) {
          final settings = watch(appSettingsNotifier);

          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: <Widget>[
              SizedBox(height: mediaQuery.padding.top + 56),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      initialPage: _sliderIndex,
                      autoPlay: true,
                      height: 180,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _sliderIndex = index;
                        });
                      },
                    ),
                    items: carList.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            height: 180,
                            width: size.width,
                            decoration: BoxDecoration(
                              color: lightGreyColor,
                              image: DecorationImage(
                                image: NetworkImage(i.imageUrl),
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
                    activeIndex: _sliderIndex,
                    count: carList.length,
                    effect: WormEffect(
                      activeDotColor: blueColor,
                      dotColor: lightGreyColor,
                      dotHeight: 8,
                      dotWidth: 8,
                    ),
                  ).padding(bottom: 24),
                ],
              ),
              Row(
                children: [
                  Styled.widget()
                      .decorated(
                        color: lightGreyColor,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://uifaces.co/our-content/donated/6MWH9Xi_.jpg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      )
                      .constrained(height: 42, width: 42),
                  SizedBox(width: 16),
                  <Widget>[
                    <Widget>[
                      Text(
                        'Verdiansyah',
                        style: TextStyle(
                          color: darkGreyColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ).flexible(),
                      SizedBox(width: 8),
                      Icon(Icons.verified, color: yellowColor),
                    ].toRow(),
                    Text(
                      'Jakarta',
                      style: TextStyle(
                        color: mediumGreyColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ]
                      .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
                      .constrained(width: size.width / 2),
                  <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.share),
                      iconSize: 32,
                      color: darkGreyColor,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.favorite),
                      iconSize: 32,
                      color: Colors.black12,
                    ),
                  ].toRow(mainAxisAlignment: MainAxisAlignment.end).expanded(),
                ],
              ).padding(horizontal: 16),
              SizedBox(height: 32),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Ferrari Heritsa',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: darkGreyColor,
                        ),
                      ),
                      Text(
                        'Used',
                        style: TextStyle(
                          fontSize: 13,
                          color: redColor,
                        ),
                      ),
                    ],
                  ).expanded(flex: 3),
                  SizedBox(width: 16),
                  WhatsAppButton(label: S.of(context).contactSeller)
                      .expanded(flex: 4),
                ],
              ).padding(horizontal: 16),
              SizedBox(height: 16),
              Text(
                NumberFormat.currency(
                  locale: settings.language,
                  symbol: 'Rp ',
                  decimalDigits: 0,
                ).format(125000000),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(decoration: TextDecoration.lineThrough),
              ).padding(horizontal: 16),
              SizedBox(height: 4),
              Text(
                NumberFormat.currency(
                  locale: settings.language,
                  symbol: 'Rp ',
                  decimalDigits: 0,
                ).format(125000000),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: greenColor),
              ).padding(horizontal: 16),
              SizedBox(height: 24),
              Row(
                children: [
                  BrandItem(image: AssetImage('assets/brands/toyota.png')),
                  SizedBox(width: 10),
                  FeatureItem(
                    image: SvgPicture.asset(
                      'assets/ic_sedan.svg',
                      height: 20,
                      width: 20,
                    ),
                    label: 'Sedan',
                  ),
                  SizedBox(width: 10),
                  FeatureItem(
                    image: SvgPicture.asset(
                      'assets/ic_fuel.svg',
                      height: 32,
                      width: 32,
                    ),
                    label: 'Gas',
                  ),
                  SizedBox(width: 10),
                  FeatureItem(
                    image: SvgPicture.asset(
                      'assets/ic_manual.svg',
                      height: 28,
                      width: 28,
                    ),
                    label: 'Manual',
                  ),
                ],
              ).padding(horizontal: 16),
              SizedBox(height: 32),
              ExpandablePanel(
                collapsed: ExpandableButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        S.of(context).description,
                        style: textTheme.headline6,
                      ),
                      Icon(
                        Icons.arrow_drop_down_rounded,
                        size: 32,
                        color: mediumGreyColor,
                      ),
                    ],
                  ),
                ).center(),
                expanded: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExpandableButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).description,
                            style: textTheme.headline6,
                          ),
                          Icon(
                            Icons.arrow_drop_up_rounded,
                            size: 32,
                            color: mediumGreyColor,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    Text('Lorem ipsum').fontWeight(FontWeight.w600),
                    SizedBox(height: 4),
                    Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.')
                  ],
                ),
              ).padding(horizontal: 16),
              SizedBox(height: 32),
              CreditSimulation().padding(horizontal: 16),
              SizedBox(height: 32),
              RoundedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => TestDrive(),
                  );
                },
                label: S.of(context).scheduleToTestDrive,
                verticalPadding: 12,
              ).padding(horizontal: 16).constrained(width: size.width),
              SizedBox(height: 32),
              <Widget>[
                Text(S.of(context).recommended, style: textTheme.headline6),
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
              SizedBox(height: 64),
            ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
          );
        },
      ),
    );
  }
}

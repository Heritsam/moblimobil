import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:moblimobil/core/themes/mobli_icons_icons.dart';
import 'package:moblimobil/presentation/widgets/buttons/rounded_icon_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructures/models/car.dart';
import '../../notifiers/app_settings/app_settings_notifier.dart';
import '../../widgets/buttons/rounded_button.dart';
import '../../widgets/cars/car_card.dart';
import '../../widgets/circle_image.dart';
import 'credit_simulation.dart';
import 'specification.dart';
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
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
        centerTitle: false,
        flexibleSpace: ClipRRect(
          child: Container(color: Colors.white60).backgroundBlur(7),
        ),
        title: Text(
          'Ferrari Heritsa',
          style: TextStyle(color: darkGreyColor, fontWeight: FontWeight.w700),
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          RoundedIconButton(
            icon: Icon(MobliIcons.chat, color: Colors.white),
            label: 'Chat Penjual',
            horizontalPadding: 0,
          ).expanded(),
          SizedBox(width: 16),
          RoundedIconButton(
            icon: Icon(Icons.phone_outlined, color: Colors.white),
            label: 'Telepon',
            horizontalPadding: 0,
            backgroundColor: darkGreyColor,
          ).expanded(),
        ],
      )
          .parent(({required child}) => SafeArea(child: child))
          .padding(all: 16)
          .backgroundColor(Colors.white.withOpacity(.85))
          .backgroundBlur(7)
          .clipRRect(),
      body: Consumer(
        builder: (context, watch, child) {
          final settings = watch(appSettingsNotifier);

          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: <Widget>[
              SizedBox(height: mediaQuery.padding.top + 56),
              Stack(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      initialPage: _sliderIndex,
                      autoPlay: true,
                      height: 200,
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
                  ),
                  Text(
                    '${_sliderIndex + 1} / ${carList.length}',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  )
                      .padding(horizontal: 12, vertical: 4)
                      .decorated(
                        borderRadius: BorderRadius.circular(150),
                        color: mediumGreyColor.withOpacity(.87),
                      )
                      .padding(top: 8, right: 8)
                      .alignment(Alignment.topRight),
                  AnimatedSmoothIndicator(
                    activeIndex: _sliderIndex,
                    count: carList.length,
                    effect: WormEffect(
                      activeDotColor: blueColor,
                      dotColor: lightGreyColor,
                      dotHeight: 8,
                      dotWidth: 8,
                    ),
                  ).padding(bottom: 20).alignment(Alignment.bottomCenter),
                ],
              ).constrained(height: 240),
              Row(
                children: [
                  CircleImage(
                    image: NetworkImage(
                      'https://uifaces.co/our-content/donated/6MWH9Xi_.jpg',
                    ),
                    size: 42,
                  ),
                  SizedBox(width: 16),
                  Row(
                    children: <Widget>[
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
                    ],
                  ).constrained(width: size.width / 2),
                  Row(
                    children: <Widget>[
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
                    ],
                    mainAxisAlignment: MainAxisAlignment.end,
                  ).expanded(),
                ],
              ).padding(horizontal: 16),
              SizedBox(height: 32),
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
                  SizedBox(height: 4),
                  Text(
                    NumberFormat.currency(
                      locale: settings.language,
                      symbol: 'Rp ',
                      decimalDigits: 0,
                    ).format(125000000),
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: blueColor,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ).padding(horizontal: 16),
              SizedBox(height: 32),
              Specification().padding(horizontal: 16),
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
              SizedBox(height: mediaQuery.padding.bottom + 64),
            ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
          );
        },
      ),
    );
  }
}

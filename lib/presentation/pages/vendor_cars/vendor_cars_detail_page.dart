import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/mobli_icons_icons.dart';
import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructures/models/car.dart';
import '../../notifiers/app_settings/app_settings_notifier.dart';
import '../../widgets/buttons/rounded_icon_button.dart';
import 'specification.dart';

class VendorCarsDetailPage extends StatefulWidget {
  @override
  _VendorCarsDetailPageState createState() => _VendorCarsDetailPageState();
}

class _VendorCarsDetailPageState extends State<VendorCarsDetailPage> {
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RoundedIconButton(
                icon: Icon(Icons.edit_outlined, color: Colors.white, size: 32),
                horizontalPadding: 24,
                verticalPadding: 20,
                backgroundColor: mediumGreyColor,
              ),
              SizedBox(height: 8),
              Text(
                'Edit',
                style: TextStyle(
                  color: mediumGreyColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(width: 16),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RoundedIconButton(
                icon: Icon(Icons.close, color: Colors.white, size: 32),
                horizontalPadding: 24,
                verticalPadding: 20,
                backgroundColor: redColor,
              ),
              SizedBox(height: 8),
              Text(
                'Delete',
                style: TextStyle(
                  color: mediumGreyColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(width: 16),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RoundedIconButton(
                icon: Icon(Icons.check, color: Colors.white, size: 32),
                horizontalPadding: 24,
                verticalPadding: 20,
                backgroundColor: greenColor,
              ),
              SizedBox(height: 8),
              Text(
                'Sold',
                style: TextStyle(
                  color: mediumGreyColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
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
              SizedBox(height: 4),
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
              SizedBox(height: mediaQuery.padding.bottom + 128),
            ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
          );
        },
      ),
    );
  }
}

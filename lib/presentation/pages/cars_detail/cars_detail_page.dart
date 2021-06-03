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
import '../../widgets/buttons/rounded_icon_button.dart';
import '../../widgets/cars/car_card.dart';
import '../../widgets/circle_image.dart';
import '../../widgets/error/empty_state.dart';
import 'sections/cars_detail_shimmer.dart';
import 'specification.dart';
import 'viewmodels/cars_detail_viewmodel.dart';

class CarsDetailArgs {
  final int carId;

  const CarsDetailArgs(this.carId);
}

class CarsDetailPage extends StatefulWidget {
  @override
  _CarsDetailPageState createState() => _CarsDetailPageState();
}

class _CarsDetailPageState extends State<CarsDetailPage> {
  late CarsDetailArgs args;
  int _sliderIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      args = ModalRoute.of(context)!.settings.arguments as CarsDetailArgs;
      context.read(carsDetailViewModel).fetch(args.carId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    return Consumer(
      builder: (context, watch, child) {
        final vm = watch(carsDetailViewModel);

        return vm.productState.when(
          initial: () => CarsDetailShimmer(),
          loading: () => CarsDetailShimmer(),
          error: (message) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white70,
                elevation: 0,
                flexibleSpace: ClipRRect(
                  child: Container(color: Colors.white60).backgroundBlur(7),
                ),
              ),
              body: EmptyState(
                onPressed: () {
                  vm.fetch(args.carId);
                },
                message: message,
              ),
            );
          },
          data: (car) {
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
                  '${car.brandName} ${car.title}',
                  style: TextStyle(
                    color: darkGreyColor,
                    fontWeight: FontWeight.w700,
                  ),
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
              body: RefreshIndicator(
                onRefresh: () async {
                  Future.wait([
                    vm.fetch(args.carId),
                  ]);
                },
                displacement: 32 + mediaQuery.padding.top,
                edgeOffset: 32 + mediaQuery.padding.top,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: <Widget>[
                    SizedBox(height: mediaQuery.padding.top + 56),
                    if (car.file.isNotEmpty)
                      Stack(
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              initialPage: _sliderIndex,
                              autoPlay: true,
                              height: size.width - 40,
                              viewportFraction: 1,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _sliderIndex = index;
                                });
                              },
                            ),
                            items: car.file.map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    height: size.width - 40,
                                    width: size.width,
                                    decoration: BoxDecoration(
                                      color: lightGreyColor,
                                      image: DecorationImage(
                                        image: NetworkImage(i.file),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                          Text(
                            '${_sliderIndex + 1} / ${car.file.length}',
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
                            count: car.file.length,
                            effect: WormEffect(
                              activeDotColor: blueColor,
                              dotColor: lightGreyColor,
                              dotHeight: 8,
                              dotWidth: 8,
                            ),
                          )
                              .padding(bottom: 20)
                              .alignment(Alignment.bottomCenter),
                        ],
                      ).constrained(height: size.width)
                    else
                      Container(
                        height: size.width - 40,
                        width: size.width,
                        color: lightGreyColor,
                        margin: EdgeInsets.only(bottom: 40),
                      ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleImage(
                          image: NetworkImage(car.userFile),
                          size: 42,
                        ),
                        SizedBox(width: 16),
                        Row(
                          children: <Widget>[
                            Text(
                              car.userFullname,
                              style: TextStyle(
                                color: darkGreyColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ).flexible(),
                            SizedBox(width: 8),
                            Icon(Icons.verified, color: yellowColor, size: 18),
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
                          '${car.brandName} ${car.title}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: darkGreyColor,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          NumberFormat.currency(
                            locale: 'id',
                            symbol: 'Rp ',
                            decimalDigits: 0,
                          ).format(int.tryParse(car.price) ?? 0),
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
                          Text(car.descriptionTitle)
                              .fontWeight(FontWeight.w600),
                          SizedBox(height: 4),
                          Text(car.description)
                        ],
                      ),
                    ).padding(horizontal: 16),
                    SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          S.of(context).recommended,
                          style: textTheme.headline6,
                        ),
                        InkResponse(
                          onTap: () {},
                          child: Text(
                            S.of(context).seeAll,
                            style: TextStyle(color: blueColor),
                          ),
                        ),
                      ],
                    ).padding(horizontal: 16),
                    SizedBox(height: 16),
                    ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: carList.length,
                      itemBuilder: (context, index) {
                        final item = carList[index];

                        return CarCard(
                          onTap: () {},
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
                ),
              ),
            );
          },
        );
      },
    );
  }
}

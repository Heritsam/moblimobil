import 'package:carousel_slider/carousel_slider.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../widgets/buttons/rounded_icon_button.dart';
import '../../widgets/dialog/custom_dialog.dart';
import '../../widgets/error/empty_state.dart';
import '../vendor_cars_edit/vendor_cars_edit_page.dart';
import 'section/vendor_cars_detail_shimmer.dart';
import 'section/vendor_specification.dart';
import 'viewmodels/vendor_cars_detail_viewmodel.dart';

class VendorCarsDetailArgs {
  final int carId;

  const VendorCarsDetailArgs(this.carId);
}

class VendorCarsDetailPage extends StatefulWidget {
  @override
  _VendorCarsDetailPageState createState() => _VendorCarsDetailPageState();
}

class _VendorCarsDetailPageState extends State<VendorCarsDetailPage> {
  late VendorCarsDetailArgs args;
  int _sliderIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read(vendorCarsDetailViewModel(args.carId)).fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as VendorCarsDetailArgs;

    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    return Consumer(
      builder: (context, watch, child) {
        final vm = watch(vendorCarsDetailViewModel(args.carId));

        return vm.productState.when(
          initial: () => VendorCarsDetailShimmer(),
          loading: () => VendorCarsDetailShimmer(),
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
                  vm.fetch();
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RoundedIconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/vendor-cars-edit',
                            arguments: VendorCarsEditArgs(car.id),
                          );
                        },
                        icon: Icon(
                          Icons.edit_outlined,
                          color: Colors.white,
                          size: 32,
                        ),
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
                        onPressed: () {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) => CustomDialog(
                              title: 'Delete Car',
                              description: 'Delete this car',
                              actions: [
                                CustomDialogAction(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  label: S.of(context).no,
                                  isDefaultAction: true,
                                ),
                                CustomDialogAction(
                                  onPressed: () {
                                    vm.delete(context);
                                  },
                                  label: S.of(context).yes,
                                  isDestructiveAction: true,
                                ),
                              ],
                            ),
                          );
                        },
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
              body: RefreshIndicator(
                onRefresh: () async {
                  Future.wait([
                    vm.fetch(),
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
                              onPageChanged: (index, _) {
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
                    SizedBox(height: 4),
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
                        if (car.type == 'used')
                          Text(
                            S.of(context).usedText,
                            style: TextStyle(color: redColor),
                          ),
                        if (car.type == 'used') SizedBox(height: 12),
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
                    VendorSpecification(car.id).padding(horizontal: 16),
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
                          Text(car.description),
                        ],
                      ),
                    ).padding(horizontal: 16),
                    SizedBox(height: 32),
                    SizedBox(height: mediaQuery.padding.bottom + 128),
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

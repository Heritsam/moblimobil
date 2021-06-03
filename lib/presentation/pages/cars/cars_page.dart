import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructures/models/car.dart';
import '../../widgets/cars/car_card.dart';
import '../../widgets/mobli_chip.dart';
import '../../widgets/search_bar.dart';
import 'compare_nav.dart';
import 'modals/sort_and_filter.dart';
import 'viewmodels/car_compare_viewmodel.dart';

enum CarsPageType { newCars, usedCars, compare, discount }

class CarsPage extends StatefulWidget {
  final CarsPageType type;

  const CarsPage({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  _CarsPageState createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _buildTitle() {
    if (widget.type == CarsPageType.newCars) return S.of(context).newCars;
    if (widget.type == CarsPageType.usedCars) return S.of(context).usedCars;
    if (widget.type == CarsPageType.discount)
      return S.of(context).discountAndPromo;
    return S.of(context).compare;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
        centerTitle: false,
        flexibleSpace: ClipRRect(
          child: Container(color: Colors.white60).backgroundBlur(7),
        ),
        title: Text(
          _buildTitle(),
          style: TextStyle(color: darkGreyColor, fontWeight: FontWeight.w700),
        ),
      ),
      bottomNavigationBar:
          widget.type == CarsPageType.compare ? CompareNav() : null,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: mediaQuery.padding.top + 56 + 16,
          bottom: 32,
        ),
        physics: BouncingScrollPhysics(),
        child: <Widget>[
          SearchBar().padding(horizontal: 16),
          SizedBox(height: 32),
          Text(S.of(context).price, style: textTheme.headline6)
              .padding(horizontal: 16),
          SizedBox(height: 12),
          ListView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16),
            children: [
              MobliChip(
                label: S.of(context).popular,
                selected: true,
              ).padding(right: 12, bottom: 24),
              MobliChip(
                onTap: () {},
                label: S.of(context).justReleased,
                selected: false,
                elevated: false,
              ).padding(right: 12, bottom: 24),
              MobliChip(
                onTap: () {},
                label: S.of(context).comingSoon,
                selected: false,
                elevated: false,
              ).padding(right: 12, bottom: 24),
            ],
          ).constrained(height: 64),
          SizedBox(height: 4),
          InkResponse(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => SortAndFilter(),
              );
            },
            child: Text(
              S.of(context).sortAndFilter,
              style: TextStyle(
                color: blueColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ).padding(horizontal: 16),
          ),
          GridView.builder(
            padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 24),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 3.3 / 4.3,
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: carList.length,
            itemBuilder: (context, index) {
              final item = carList[index];

              return CarCard(
                onTap: () {
                  if (widget.type == CarsPageType.compare) {
                    return context
                        .read(carCompareViewModel)
                        .addCar(context: context, car: item);
                  }

                },
                carId: item.id,
                hasUsed: widget.type == CarsPageType.usedCars,
                title: item.title,
                price: item.price,
                imageUrl: item.imageUrl,
                size: mediaQuery.size.width / 2 - 24,
              );
            },
          ),
        ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
      ),
    );
  }
}

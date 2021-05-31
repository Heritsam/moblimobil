import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/mobli_icons_icons.dart';
import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructures/models/car.dart';
import '../../widgets/cars/car_card.dart';
import '../../widgets/mobli_chip.dart';
import '../../widgets/search_bar.dart';
import '../cars/modals/sort_and_filter.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white70,
        elevation: 0,
        centerTitle: false,
        flexibleSpace: ClipRRect(
          child: Container(color: Colors.white60).backgroundBlur(7),
        ),
        title: Text(
          S.of(context).explore,
          style: TextStyle(color: darkGreyColor, fontWeight: FontWeight.w700),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => SortAndFilter(),
          );
        },
        label: Text('Sort & Filter', style: TextStyle(color: darkGreyColor)),
        icon: Icon(MobliIcons.sort_and_filter, color: darkGreyColor),
        backgroundColor: Colors.white,
      ).padding(bottom: mediaQuery.padding.bottom),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: mediaQuery.padding.top + 56 + 16,
          bottom: 32,
        ),
        physics: BouncingScrollPhysics(),
        child: <Widget>[
          SearchBar().padding(horizontal: 16),
          SizedBox(height: 32),
          Text(S.of(context).category, style: textTheme.headline6)
              .padding(horizontal: 16),
          SizedBox(height: 16),
          ListView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16),
            children: [
              MobliChip(
                label: S.of(context).forYou,
                selected: true,
              ).padding(right: 12, bottom: 24),
              MobliChip(
                onTap: () {
                  Navigator.pushNamed(context, '/search-recent');
                },
                label: S.of(context).recentlySeen,
                selected: false,
                elevated: false,
              ).padding(right: 12, bottom: 24),
              MobliChip(
                onTap: () {
                  Navigator.pushNamed(context, '/new-cars');
                },
                label: S.of(context).newCars,
                selected: false,
                elevated: false,
              ).padding(right: 12, bottom: 24),
              MobliChip(
                onTap: () {
                  Navigator.pushNamed(context, '/used-cars');
                },
                label: S.of(context).usedCars,
                selected: false,
                elevated: false,
              ).padding(right: 12, bottom: 24),
            ],
          ).constrained(height: 64),
          GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
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
                  Navigator.pushNamed(context, '/cars-detail');
                },
                carId: item.id,
                hasUsed: index.isOdd,
                title: item.title,
                price: item.price,
                imageUrl: item.imageUrl,
                size: mediaQuery.size.width / 2 - 24,
              );
            },
          ),
          SizedBox(height: 32 + mediaQuery.padding.top),
        ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
      ),
    );
  }
}

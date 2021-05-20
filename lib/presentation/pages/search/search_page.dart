import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../generated/l10n.dart';
import '../../../infrastructures/models/car.dart';
import '../../widgets/cars/car_card.dart';
import '../../widgets/search_bar.dart';

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
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: mediaQuery.padding.top + 56 + 16,
          bottom: 32,
        ),
        physics: BouncingScrollPhysics(),
        child: <Widget>[
          SearchBar().padding(horizontal: 16),
          SizedBox(height: 32),
          Text(S.of(context).searchResult, style: textTheme.headline6)
              .padding(horizontal: 16),
          GridView.builder(
            padding: EdgeInsets.all(16),
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
                carId: item.id,
                hasUsed: index.isOdd,
                title: item.title,
                price: item.price,
                imageUrl:
                    'https://images.unsplash.com/photo-1574438085144-72418a474aa9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80',
              );
            },
          ).parent(({required child}) => Scrollbar(child: child)),
          SizedBox(height: 32 + mediaQuery.padding.top),
        ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
      ),
    );
  }
}

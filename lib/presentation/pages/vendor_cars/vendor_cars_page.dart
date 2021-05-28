import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructures/models/car.dart';
import '../../widgets/buttons/circle_button.dart';
import '../../widgets/cars/car_card.dart';

class VendorCarsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
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
          S.of(context).cars,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      floatingActionButton: CircleButton(
        onPressed: () {
          Navigator.pushNamed(context, '/vendor-cars-add');
        },
        child: Icon(Icons.add, size: 32, color: Colors.white),
        backgroundColor: greenColor,
      ),
      body: GridView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          right: 16,
          left: 16,
          top: mediaQuery.padding.top + 72,
          bottom: mediaQuery.padding.bottom + 64,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 3.3 / 4.3,
        ),
        itemCount: carList.length,
        itemBuilder: (context, index) {
          final item = carList[index];

          return CarCard(
            onTap: () {
              Navigator.pushNamed(context, '/vendor-cars-detail');
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
    );
  }
}

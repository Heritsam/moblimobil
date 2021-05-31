import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../notifiers/wishlist/wishlist_notifier.dart';
import '../../widgets/cars/car_card.dart';

class WishlistPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final wishlist = watch(wishlistNotifier);
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);

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
          'Wishlist',
          style: textTheme.headline6?.copyWith(color: darkGreyColor),
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.only(
          top: mediaQuery.padding.top + 56 + 16,
          left: 16,
          right: 16,
          bottom: 24,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 5.2 / 6.2,
        ),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: wishlist.wishlists.length,
        itemBuilder: (context, index) {
          final item = wishlist.wishlists[index];

          return CarCard(
            onTap: () {
              Navigator.pushNamed(context, '/cars-detail');
            },
            carId: item.id,
            title: item.title,
            price: item.price,
            imageUrl: item.imageUrl,
          );
        },
      ),
    );
  }
}

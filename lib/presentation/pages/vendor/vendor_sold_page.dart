import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../cars_detail/cars_detail_page.dart';
import '../vendor_cars/vendor_cars_detail_page.dart';
import 'package:shimmer/shimmer.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructures/models/car.dart';
import '../../widgets/cars/car_card.dart';
import '../../widgets/error/empty_state.dart';
import '../account/viewmodels/vendor_sold_notifier.dart';

class VendorSoldPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final mediaQuery = MediaQuery.of(context);

    final vm = watch(vendorSoldNotifier);

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
          S.of(context).sold,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: vm.carState.when(
        initial: () => _Jerangkong(),
        loading: () => _Jerangkong(),
        error: (message) {
          return EmptyState(
            onPressed: vm.fetch,
            message: message,
          );
        },
        data: (cars) {
          return RefreshIndicator(
            onRefresh: () async {
              Future.wait([
                vm.fetch(),
              ]);
            },
            displacement: 32 + mediaQuery.padding.top,
            edgeOffset: 32 + mediaQuery.padding.top,
            child: GridView.builder(
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
              itemCount: cars.length,
              itemBuilder: (context, index) {
                final item = cars[index];

                return CarCard(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/cars-detail',
                      arguments: CarsDetailArgs(item.id),
                    );
                  },
                  carId: item.id,
                  hasUsed: item.type == 'used',
                  title: '${item.brandName} ${item.title}',
                  price: int.tryParse(item.price) ?? 0,
                  imageUrl: item.file.isNotEmpty
                      ? item.file.first.file
                      : 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png',
                  size: mediaQuery.size.width / 2 - 24,
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _Jerangkong extends StatelessWidget {
  const _Jerangkong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return GridView.builder(
      padding: EdgeInsets.only(
        right: 16,
        left: 16,
        top: mediaQuery.padding.top + 16,
        bottom: mediaQuery.padding.bottom + 64,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 3.3 / 4.3,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: lightGreyColor,
          highlightColor: Colors.white24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: mediaQuery.size.width / 2 - 24,
                width: mediaQuery.size.width / 2 - 24,
                decoration: BoxDecoration(
                  color: lightGreyColor,
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 16,
                width: mediaQuery.size.width / 3,
                decoration: BoxDecoration(
                  color: lightGreyColor,
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 14,
                width: mediaQuery.size.width / 1.2,
                decoration: BoxDecoration(
                  color: lightGreyColor,
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

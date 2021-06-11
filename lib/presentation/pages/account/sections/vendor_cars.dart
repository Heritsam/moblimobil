import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../core/themes/mobli_icons_icons.dart';
import '../../../../core/themes/theme.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/mobli_card.dart';
import '../viewmodels/vendor_cars_notifier.dart';

class VendorCars extends ConsumerWidget {
  const VendorCars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final notifier = watch(vendorCarsNotifier);

    return notifier.carState.when(
      initial: () => _Jerangkong(),
      loading: () => _Jerangkong(),
      error: (message) {
        return MobliCard(
          onTap: () {
            notifier.fetch();
          },
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: redColor,
                size: 64,
              ),
              SizedBox(width: 16),
              Text(
                message,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: darkGreyColor,
                ),
              ).expanded(),
              SizedBox(width: 8),
            ],
          ),
        );
      },
      data: (cars) {
        return MobliCard(
          onTap: () {
            Navigator.pushNamed(context, '/vendor-cars');
          },
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                MobliIcons.car_alt,
                color: greenColor,
                size: 64,
              ),
              SizedBox(width: 16),
              Text(
                S.of(context).cars,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: darkGreyColor,
                ),
              ),
              Spacer(),
              Text(
                notifier.totalCar.toString(),
                style: TextStyle(
                  color: greenColor,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 8),
            ],
          ),
        );
      },
    );
  }
}

class _Jerangkong extends StatelessWidget {
  const _Jerangkong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MobliCard(
      padding: EdgeInsets.all(16),
      child: Shimmer.fromColors(
        baseColor: lightGreyColor,
        highlightColor: Colors.white24,
        child: Row(
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                color: lightGreyColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 16),
            Container(
              height: 14,
              decoration: BoxDecoration(
                color: lightGreyColor,
                borderRadius: BorderRadius.circular(defaultBorderRadius),
              ),
            ).expanded(),
            SizedBox(width: 16),
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: lightGreyColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}

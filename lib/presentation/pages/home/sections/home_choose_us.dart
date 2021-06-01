import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../core/themes/theme.dart';
import '../../../widgets/cars/menu_item.dart';
import '../feature_detail_page.dart';
import '../viewmodels/choose_us_notifier.dart';

class HomeChooseUs extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final state = watch(chooseUsNotifier);

    if (state.isLoading) {
      return Shimmer.fromColors(
        baseColor: lightGreyColor,
        highlightColor: Colors.white24,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 73,
              width: 73,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: lightGreyColor,
              ),
            ).expanded(),
            SizedBox(width: 16),
            Container(
              height: 73,
              width: 73,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: lightGreyColor,
              ),
            ).expanded(),
            SizedBox(width: 16),
            Container(
              height: 73,
              width: 73,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: lightGreyColor,
              ),
            ).expanded(),
          ],
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: state.items.map((item) {
        return MenuItem(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/feature-detail',
              arguments: FeatureDetailArgs(
                title: item.title,
                image: NetworkImage(item.file),
              ),
            );
          },
          icon: Image.network(item.file),
          label: item.title,
        ).expanded();
      }).toList(),
      // children: [
      //   MenuItem(
      //     onTap: () {
      //       Navigator.pushNamed(
      //         context,
      //         '/feature-detail',
      //         arguments: FeatureDetailArgs(
      //           title: 'Garansi 1 Tahun',
      //           image: AssetImage('assets/feature_1.png'),
      //         ),
      //       );
      //     },
      //     icon: Image.asset('assets/feature_1.png'),
      //     label: 'Garansi 1 Tahun',
      //   ).expanded(),
      //   SizedBox(width: 16),
      //   MenuItem(
      //     onTap: () {
      //       Navigator.pushNamed(
      //         context,
      //         '/feature-detail',
      //         arguments: FeatureDetailArgs(
      //           title: 'Tersertifikasi',
      //           image: AssetImage('assets/feature_2.png'),
      //         ),
      //       );
      //     },
      //     icon: Image.asset('assets/feature_2.png'),
      //     label: 'Tersertifikasi',
      //   ).expanded(),
      //   SizedBox(width: 16),
      //   MenuItem(
      //     onTap: () {
      //       Navigator.pushNamed(
      //         context,
      //         '/feature-detail',
      //         arguments: FeatureDetailArgs(
      //           title: 'Garansi Uang Kembali',
      //           image: AssetImage('assets/feature_3.png'),
      //         ),
      //       );
      //     },
      //     icon: Image.asset('assets/feature_3.png'),
      //     label: 'Garansi Uang Kembali',
      //   ).expanded(),
      // ],
    );
  }
}

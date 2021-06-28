import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../core/themes/mobli_icons_icons.dart';
import '../../../../core/themes/theme.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/circle_image.dart';
import '../../../widgets/error/empty_state.dart';
import '../../../widgets/mobli_card.dart';
import '../sections/vendor_cars.dart';
import '../sections/vendor_sold.dart';
import '../viewmodels/account_user_notifier.dart';
import '../viewmodels/vendor_cars_notifier.dart';
import '../viewmodels/vendor_sold_notifier.dart';

class AccountVendor extends StatefulWidget {
  @override
  _AccountVendorState createState() => _AccountVendorState();
}

class _AccountVendorState extends State<AccountVendor> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Consumer(
      builder: (context, watch, child) {
        final userNotifier = watch(accountUserNotifier);

        return ProviderListener(
          provider: accountUserNotifier,
          onChange: (context, AccountUserNotifier notifier) {
            notifier.userState.maybeWhen(
              data: (user) {
                if (user.statusVendor == 'active') {
                  context.read(vendorCarsNotifier).fetch();
                  context.read(vendorSoldNotifier).fetch();
                }
              },
              orElse: () {},
            );
          },
          child: userNotifier.userState.when(
            initial: () => _Jerangkong(),
            loading: () => _Jerangkong(),
            data: (user) {
              if (user.isVendor == 'pending') {
                return EmptyState(
                  title: 'Pending',
                  message: 'Sedang menunggu verifikasi admin',
                );
              }

              if (user.isVendor != 'true') {
                return EmptyState(
                  onPressed: () {
                    Navigator.pushNamed(context, '/vendor-register');
                  },
                  message: S.of(context).vendorInactive,
                  buttonLabel: S.of(context).register,
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  Future.wait([
                    userNotifier.fetchUser(),
                  ]);
                },
                displacement: mediaQuery.padding.top,
                edgeOffset: mediaQuery.padding.top,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  padding: EdgeInsets.only(
                    top: mediaQuery.padding.top + 16,
                    right: 16,
                    left: 16,
                    bottom: mediaQuery.padding.bottom,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              if (user.file?.contains('http') ?? false)
                                CircleImage(
                                  size: 120,
                                  image: NetworkImage(user.file!),
                                )
                              else
                                CircleImage(
                                  size: 120,
                                  image:
                                      AssetImage('assets/profile_picture.png'),
                                ),
                              if (user.isVerified ?? false)
                                Icon(Icons.verified,
                                        size: 18, color: yellowColor)
                                    .padding(all: 4)
                                    .backgroundColor(Colors.white)
                                    .clipOval()
                                    .elevation(
                                      8,
                                      borderRadius: BorderRadius.circular(150),
                                      shadowColor: Colors.black26,
                                    )
                                    .alignment(Alignment.topRight)
                                    .padding(top: 4, right: 4),
                            ],
                          ).constrained(height: 120, width: 120),
                          SizedBox(height: 16),
                          Text(
                            user.fullname,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: darkGreyColor,
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8),
                          Text(
                            user.formattedPhone,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: greenColor,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 32),
                          VendorCars(),
                          SizedBox(height: 16),
                          VendorSold(),
                          SizedBox(height: 16),
                          MobliCard(
                            onTap: () {
                              Navigator.pushNamed(context, '/iuran');
                            },
                            padding: EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Icon(MobliIcons.iuran,
                                    color: greenColor, size: 64),
                                SizedBox(width: 16),
                                Text(
                                  S.of(context).iuran,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: darkGreyColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: mediaQuery.padding.bottom),
                    ],
                  ),
                ),
              );
            },
            error: (message) {
              return EmptyState(
                onPressed: () {
                  userNotifier.fetchUser();
                },
                message: message,
              );
            },
          ),
        );
      },
    );
  }
}

class _Jerangkong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(
        top: mediaQuery.padding.top + 16,
        bottom: mediaQuery.padding.bottom,
      ),
      child: Shimmer.fromColors(
        baseColor: lightGreyColor,
        highlightColor: Colors.white24,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: lightGreyColor,
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: mediaQuery.size.width / 2,
                  height: 18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(defaultBorderRadius),
                    color: lightGreyColor,
                  ),
                ),
              ],
            ).center(),
          ],
        ),
      ),
    );
  }
}

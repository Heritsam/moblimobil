import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../core/themes/mobli_icons_icons.dart';
import '../../../../core/themes/theme.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/circle_image.dart';
import '../../../widgets/error/empty_state.dart';
import '../../../widgets/mobli_card.dart';
import '../viewmodels/account_user_notifier.dart';

class AccountVendor extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final mediaQuery = MediaQuery.of(context);

    final state = watch(accountUserNotifier);

    return state.userState.when(
      initial: () => _Jerangkong(),
      loading: () => _Jerangkong(),
      data: (user) {
        if (user.statusVendor != 'active') {
          return EmptyState(
            onPressed: () {},
            message: S.of(context).vendorInactive,
            buttonLabel: S.of(context).register,
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            Future.wait([
              state.fetchUser(),
            ]);
          },
          displacement: mediaQuery.padding.top,
          edgeOffset: mediaQuery.padding.top,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
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
                        if (user.file != null)
                          CircleImage(
                            size: 120,
                            image: NetworkImage(user.file!),
                          )
                        else
                          CircleImage(
                            size: 120,
                            image: AssetImage('assets/profile_picture.png'),
                          ),
                        if (user.isVerified ?? false)
                          Icon(Icons.verified, size: 18, color: yellowColor)
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
                      user.phone,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: greenColor,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 32),
                    MobliCard(
                      onTap: () {
                        Navigator.pushNamed(context, '/vendor-cars');
                      },
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(MobliIcons.car_alt, color: greenColor, size: 64),
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
                            '12',
                            style: TextStyle(
                              color: greenColor,
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 8),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    MobliCard(
                      onTap: () {
                        Navigator.pushNamed(context, '/vendor-sold');
                      },
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(MobliIcons.sold, color: greenColor, size: 64),
                          SizedBox(width: 16),
                          Text(
                            S.of(context).sold,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: darkGreyColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '9',
                            style: TextStyle(
                              color: greenColor,
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 8),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    MobliCard(
                      onTap: () {
                        Navigator.pushNamed(context, '/iuran');
                      },
                      padding: EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(MobliIcons.iuran, color: greenColor, size: 64),
                          SizedBox(width: 16),
                          Text(
                            S.of(context).iuran,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: darkGreyColor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            NumberFormat.compactCurrency(
                                  locale: 'en',
                                  decimalDigits: 0,
                                  symbol: 'Rp ',
                                ).format(123000) +
                                '/' +
                                S.of(context).month,
                            style: TextStyle(
                              color: mediumGreyColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 8),
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
            state.fetchUser();
          },
          message: message,
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

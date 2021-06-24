import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../core/themes/theme.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/circle_image.dart';
import '../../../widgets/error/empty_state.dart';
import '../../../widgets/mobli_chip.dart';
import '../../../widgets/mobli_tile.dart';
import '../../../widgets/wishlist/wishlist_tile.dart';
import '../sections/account_bookmark.dart';
import '../sections/account_wishlist.dart';
import '../viewmodels/account_bookmark_notifier.dart';
import '../viewmodels/account_user_notifier.dart';
import '../viewmodels/account_wishlist_notifier.dart';

class AccountUser extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final mediaQuery = MediaQuery.of(context);

    final state = watch(accountUserNotifier);

    return state.userState.when(
      initial: () => _Jerangkong(),
      loading: () => _Jerangkong(),
      data: (user) {
        return RefreshIndicator(
          onRefresh: () async {
            Future.wait([
              state.fetchUser(),
              context.read(accountWishlistNotifier).getWishlists(),
              context.read(accountBookmarkNotifier).getBookmarks(),
            ]);
          },
          displacement: mediaQuery.padding.top,
          edgeOffset: mediaQuery.padding.top,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              top: mediaQuery.padding.top + 16,
              bottom: mediaQuery.padding.bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (user.file?.contains('http') ?? false)
                      CircleImage(
                        size: 120,
                        image: NetworkImage(user.file!),
                      )
                    else
                      CircleImage(
                        size: 120,
                        image: AssetImage('assets/profile_picture.png'),
                      ),
                    SizedBox(height: 16),
                    Text(
                      'Hi! ${user.fullname}',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: darkGreyColor,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ).center(),
                SizedBox(height: 24),
                ListView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    MobliChip(
                      onTap: () {
                        state.changeTabIndex(0);
                      },
                      label: S.of(context).newest,
                      selected: state.tabIndex == 0,
                      elevated: state.tabIndex == 0,
                    ).padding(right: 8, bottom: 24),
                    MobliChip(
                      onTap: () {
                        state.changeTabIndex(1);
                      },
                      label: S.of(context).savedNewsAndReview,
                      selected: state.tabIndex == 1,
                      elevated: state.tabIndex == 1,
                    ).padding(right: 8, bottom: 24),
                    MobliChip(
                      onTap: () {
                        state.changeTabIndex(2);
                      },
                      label: S.of(context).wishlist,
                      selected: state.tabIndex == 2,
                      elevated: state.tabIndex == 2,
                    ).padding(right: 8, bottom: 24),
                  ],
                ).constrained(height: 64),
                SizedBox(height: 16),
                _buildTabBody(state.tabIndex),
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

  Widget _buildTabBody(int index) {
    if (index == 0) {
      return Column(
        children: [
          AccountBookmark(limit: true),
          AccountWishlist(limit: true),
        ],
      );
    }

    if (index == 1) {
      return AccountBookmark();
    }

    return AccountWishlist();
  }
}

class _Jerangkong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
            SizedBox(height: 24),
            ListView(
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                MobliChip(
                  label: S.of(context).newest,
                  selected: true,
                ).padding(right: 8, bottom: 24),
                MobliChip(
                  label: S.of(context).savedNewsAndReview,
                  selected: false,
                  elevated: false,
                ).padding(right: 8, bottom: 24),
                MobliChip(
                  label: S.of(context).wishlist,
                  selected: false,
                  elevated: false,
                ).padding(right: 8, bottom: 24),
              ],
            ).constrained(height: 64),
            SizedBox(height: 16),
            Text(
              S.of(context).savedNewsAndReview,
              style: textTheme.headline6,
            ).padding(horizontal: 16),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(16),
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                return MobliTile(
                  imageUrl: '',
                  title: 'Lorem Ipsum dolor sit amet',
                  subtitle: Row(
                    children: [
                      Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: lightGreyColor,
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        height: 12,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(defaultBorderRadius),
                          color: lightGreyColor,
                        ),
                      ).expanded(),
                    ],
                  ),
                ).padding(bottom: 16);
              },
            ),
            Text(
              S.of(context).wishlist,
              style: textTheme.headline6,
            ).padding(horizontal: 16),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(16),
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                return WishlistTile(
                  imageUrl: '',
                  title: 'Laku Mobil',
                  price: 0,
                  subtitle: Row(
                    children: [
                      Container(
                        height: 28,
                        width: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: lightGreyColor,
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        height: 12,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(defaultBorderRadius),
                          color: lightGreyColor,
                        ),
                      ).expanded(),
                    ],
                  ),
                ).padding(bottom: 16);
              },
            ),
          ],
        ),
      ),
    );
  }
}

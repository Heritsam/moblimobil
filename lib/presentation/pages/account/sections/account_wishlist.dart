import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../../core/themes/theme.dart';
import '../../../../generated/l10n.dart';
import '../../../widgets/circle_image.dart';
import '../../../widgets/dialog/custom_dialog.dart';
import '../../../widgets/shimmer/shimmer_mobli_tile.dart';
import '../../../widgets/wishlist/wishlist_tile.dart';
import '../../cars_detail/cars_detail_page.dart';
import '../viewmodels/account_wishlist_notifier.dart';

class AccountWishlist extends StatelessWidget {
  final bool limit;

  const AccountWishlist({
    Key? key,
    this.limit = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).wishlist,
          style: textTheme.headline6,
        ).padding(horizontal: 16),
        Consumer(
          builder: (context, watch, child) {
            final state = watch(accountWishlistNotifier);

            if (state.isLoading) {
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(16),
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return ShimmerMobliTile().padding(bottom: 16);
                },
              );
            }

            if (state.items.isEmpty) {
              return Text('No Items').center().constrained(height: 120);
            }

            final itemCount = limit ? 2 : state.items.length;

            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(16),
              shrinkWrap: true,
              itemCount:
                  state.items.length >= 2 ? itemCount : state.items.length,
              itemBuilder: (context, index) {
                final item = state.items[index];

                return WishlistTile(
                  onLongPress: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CustomDialog(
                        title: 'Remove',
                        description: 'Remove wishlist?',
                        actions: [
                          CustomDialogAction(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            label: S.of(context).no,
                            isDefaultAction: true,
                          ),
                          CustomDialogAction(
                            onPressed: () {
                              state.removeWishlist(context, item.id);
                              Navigator.popUntil(
                                context,
                                ModalRoute.withName('/home'),
                              );
                            },
                            label: S.of(context).yes,
                            isDestructiveAction: true,
                          ),
                        ],
                      ),
                    );
                  },
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/cars-detail',
                      arguments: CarsDetailArgs(item.keyId),
                    );
                  },
                  imageUrl: item.file,
                  title: item.title,
                  price: int.tryParse(item.price ?? '0') ?? 0,
                  subtitle: Row(
                    children: [
                      CircleImage(
                        image: NetworkImage(item.vendorFile ?? ''),
                        size: 28,
                      ),
                      SizedBox(width: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            item.vendorName ?? '-',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: mediumGreyColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(width: 8),
                          if (item.vendorName == 'true')
                            Icon(
                              Icons.verified,
                              color: yellowColor,
                              size: 20,
                            ),
                        ],
                      ).expanded(),
                    ],
                  ),
                ).padding(bottom: 16);
              },
            );
          },
        ),
      ],
    );
  }
}

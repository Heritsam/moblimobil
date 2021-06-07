import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/themes/theme.dart';
import '../../../../generated/l10n.dart';
import '../../../notifiers/app_settings/app_settings_notifier.dart';
import '../../../widgets/dialog/custom_dialog.dart';
import '../../../widgets/mobli_tile.dart';
import '../../../widgets/shimmer/shimmer_mobli_tile.dart';
import '../../news/news_detail_page.dart';
import '../viewmodels/account_bookmark_notifier.dart';

class AccountBookmark extends StatelessWidget {
  final bool limit;

  const AccountBookmark({
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
          S.of(context).savedNewsAndReview,
          style: textTheme.headline6,
        ).padding(horizontal: 16),
        Consumer(
          builder: (context, watch, child) {
            final appSettings = watch(appSettingsNotifier);
            final state = watch(accountBookmarkNotifier);

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

                return MobliTile(
                  onLongPress: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CustomDialog(
                        title: 'Remove',
                        description: 'Remove bookmark?',
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
                              state.removeBookmark(context, item.id);
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
                      '/news-detail',
                      arguments: NewsDetailArgs(item.keyId),
                    );
                  },
                  imageUrl: item.file,
                  title: item.title,
                  subtitle: Row(
                    children: [
                      Text(
                        timeago.format(
                          item.createdAt,
                          locale: appSettings.language,
                        ),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: mediumGreyColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
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

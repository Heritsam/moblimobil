import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../widgets/error/empty_state.dart';
import 'notification_detail_page.dart';
import 'viewmodels/notification_viewmodel.dart';

class NotificationPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);

    final vm = watch(notificationViewModel);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        centerTitle: false,
        elevation: 0,
        leading: BackButton(color: darkGreyColor),
        title: Text(
          S.of(context).notification,
          style: textTheme.headline6?.copyWith(color: darkGreyColor),
        ),
      ),
      body: vm.notifState.when(
        initial: () => _Jerangkong(),
        loading: () => _Jerangkong(),
        error: (message) {
          return EmptyState(
            onPressed: vm.fetch,
            message: message,
          );
        },
        data: (items) {
          return RefreshIndicator(
            onRefresh: () async {
              Future.wait([
                vm.fetch(),
              ]);
            },
            displacement: 32 + mediaQuery.padding.top,
            edgeOffset: 32 + mediaQuery.padding.top,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          item.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ).expanded(flex: 3),
                        Text(
                          DateFormat('dd/MM/yyyy').format(item.createdAt),
                          style: textTheme.caption?.copyWith(color: greenColor),
                          textAlign: TextAlign.end,
                        ).expanded(),
                      ],
                    ).padding(horizontal: 16, top: 16),
                    SizedBox(height: 8),
                    Text(
                      item.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ).padding(horizontal: 16, bottom: 16),
                  ],
                )
                    .ripple()
                    .backgroundColor(
                      item.isRead!
                          ? lightGreyColor.withOpacity(.54)
                          : blueColor.withOpacity(.30),
                    )
                    .gestures(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/notification-detail',
                      arguments: NotificationDetailArgs(item.id),
                    );
                  },
                ).padding(bottom: 4);
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

    return ListView.builder(
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
                height: 16,
                width: mediaQuery.size.width / 3,
                margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                  color: lightGreyColor,
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 14,
                width: mediaQuery.size.width / 2,
                margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                  color: lightGreyColor,
                ),
              ),
            ],
          )
              .ripple()
              .backgroundColor(
                lightGreyColor.withOpacity(.54),
              )
              .gestures(
            onTap: () {
              Navigator.pushNamed(context, '/notification-detail');
            },
          ).padding(bottom: 4),
        );
      },
    );
  }
}

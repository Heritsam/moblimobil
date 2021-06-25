import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../widgets/error/empty_state.dart';
import '../../widgets/mobli_loading_indicator.dart';
import 'viewmodels/notification_detail_viewmodel.dart';

class NotificationDetailArgs {
  final int notifId;

  const NotificationDetailArgs(this.notifId);
}

class NotificationDetailPage extends StatefulWidget {
  @override
  _NotificationDetailPageState createState() => _NotificationDetailPageState();
}

class _NotificationDetailPageState extends State<NotificationDetailPage> {
  late NotificationDetailArgs args;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read(notificationDetailViewModel(args.notifId)).fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)!.settings.arguments as NotificationDetailArgs;
    final textTheme = Theme.of(context).textTheme;

    return Consumer(
      builder: (context, watch, child) {
        final vm = watch(notificationDetailViewModel(args.notifId));

        return vm.notifState.when(
          initial: () => _Jerangkong(),
          loading: () => _Jerangkong(),
          error: (message) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white70,
                elevation: 0,
                flexibleSpace: ClipRRect(
                  child: Container(color: Colors.white60).backgroundBlur(7),
                ),
              ),
              body: EmptyState(
                onPressed: vm.fetch,
                message: message,
              ),
            );
          },
          data: (item) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white70,
                centerTitle: false,
                elevation: 0,
                leading: BackButton(color: darkGreyColor),
                title: Text(
                  S.of(context).detail,
                  style: textTheme.headline6?.copyWith(color: darkGreyColor),
                ),
              ),
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(16),
                child: <Widget>[
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 20,
                      color: darkGreyColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(item.description)
                ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
              ),
            );
          },
        );
      },
    );
  }
}

class _Jerangkong extends StatelessWidget {
  const _Jerangkong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
        flexibleSpace: ClipRRect(
          child: Container(color: Colors.white60).backgroundBlur(7),
        ),
      ),
      body: Center(
        child: MobliLoadingIndicator(),
      ),
    );
  }
}

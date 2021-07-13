import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../notifiers/about/about_notifier.dart';
import '../../widgets/error/empty_state.dart';
import '../../widgets/mobli_loading_indicator.dart';

class AboutPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    final notifier = watch(aboutNotifier);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white70,
        elevation: 0,
        centerTitle: false,
        title: Text(
          S.of(context).aboutUs,
          style: TextStyle(color: darkGreyColor, fontWeight: FontWeight.w700),
        ),
        flexibleSpace: ClipRRect(
          child: Container(color: Colors.white60).backgroundBlur(7),
        ),
      ),
      body: notifier.aboutState.when(
        initial: () => _Jerangkong(),
        loading: () => _Jerangkong(),
        error: (message) {
          return EmptyState(
            onPressed: notifier.fetch,
            message: message,
          );
        },
        data: (item) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              top: mediaQuery.padding.top + 56,
              bottom: 32,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: size.width,
                  height: 210,
                  decoration: BoxDecoration(
                    color: lightGreyColor,
                    image: DecorationImage(
                      image: NetworkImage(item.aboutUsImg),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  item.brandName,
                  style: TextStyle(
                    color: darkGreyColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ).padding(horizontal: 16),
                SizedBox(height: 16),
                Html(data: item.aboutUs).padding(horizontal: 8),
              ],
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
    return Center(
      child: MobliLoadingIndicator(),
    );
  }
}

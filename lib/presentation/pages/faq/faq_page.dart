import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../widgets/error/empty_state.dart';
import 'viewmodels/faq_viewmodel.dart';

class FaqPage extends StatefulWidget {
  @override
  _FaqPageState createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read(faqViewModel.notifier).fetchFaq();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white70,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'FAQ',
          style: TextStyle(color: darkGreyColor, fontWeight: FontWeight.w700),
        ),
        flexibleSpace: ClipRRect(
          child: Container(color: Colors.white60).backgroundBlur(7),
        ),
      ),
      body: Consumer(builder: (context, watch, child) {
        final state = watch(faqViewModel);
        
        return state.when(
          initial: () {
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                top: mediaQuery.padding.top + 56 + 16,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              itemCount: 3,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: lightGreyColor,
                  highlightColor: Colors.white24,
                  child: Container(
                    height: 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                      color: lightGreyColor,
                    ),
                  ),
                )
                    .padding(all: 24)
                    .decorated(color: Colors.white)
                    .clipRRect(all: defaultBorderRadius)
                    .elevation(
                      10,
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                      shadowColor: Colors.black38,
                    )
                    .padding(bottom: 16);
              },
            );
          },
          data: (items) {
            return RefreshIndicator(
              onRefresh: () async {
                return context.read(faqViewModel.notifier).fetchFaq();
              },
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(
                  top: mediaQuery.padding.top + 56 + 16,
                  left: 16,
                  right: 16,
                  bottom: 16,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];

                  return _buildItem(item.pertanyaan, item.jawaban)
                      .padding(bottom: 16);
                },
              ),
            );
          },
          error: (message) {
            return EmptyState(
              onPressed: () {
                return context.read(faqViewModel.notifier).fetchFaq();
              },
              message: message,
            );
          },
        );
      }),
    );
  }

  Widget _buildItem(String title, String description) {
    return ExpandablePanel(
      collapsed: ExpandableButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: darkGreyColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ).expanded(),
            Icon(
              Icons.arrow_drop_down_rounded,
              size: 32,
              color: mediumGreyColor,
            ),
          ],
        ).padding(all: 16),
      ),
      expanded: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpandableButton(
            theme: ExpandableThemeData(
              iconPadding: EdgeInsets.all(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: darkGreyColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ).expanded(),
                Icon(
                  Icons.arrow_drop_up_rounded,
                  size: 32,
                  color: mediumGreyColor,
                ),
              ],
            ).padding(all: 16),
          ),
          Text(description).padding(horizontal: 16, bottom: 16),
        ],
      ),
    )
        .ripple()
        .decorated(color: Colors.white)
        .clipRRect(all: defaultBorderRadius)
        .elevation(
          10,
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          shadowColor: Colors.black38,
        );
  }
}

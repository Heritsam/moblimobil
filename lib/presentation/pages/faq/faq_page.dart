import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/theme.dart';

class FaqPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
          style: textTheme.headline6?.copyWith(color: darkGreyColor),
        ),
        flexibleSpace: ClipRRect(
          child: Container(color: Colors.white60).backgroundBlur(7),
        ),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          top: mediaQuery.padding.top + 56 + 16,
          left: 16,
          right: 16,
          bottom: 16,
        ),
        itemCount: 3,
        itemBuilder: (context, index) {
          return _buildItem(
            'Lorem Ipsum',
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
          ).padding(bottom: 16);
        },
      ),
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
            ),
            Icon(
              Icons.arrow_drop_down_rounded,
              size: 32,
              color: mediumGreyColor,
            ),
          ],
        ).padding(all: 16),
      ),
      expanded: Column(
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
                ),
                Icon(
                  Icons.arrow_drop_up_rounded,
                  size: 32,
                  color: mediumGreyColor,
                ),
              ],
            ).padding(all: 16),
          ),
          Text(
            description,
            style: TextStyle(color: darkGreyColor.withOpacity(.70)),
          ).padding(horizontal: 16, bottom: 16),
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

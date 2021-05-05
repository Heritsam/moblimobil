import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../core/theme.dart';
import '../../generated/l10n.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return <Widget>[
      TextField(
        decoration: InputDecoration(
          hintText: S.of(context).searchForCars,
          hintStyle: TextStyle(color: mediumGreyColor),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16),
        ),
      ).expanded(),
      Styled.widget(
        child: Icon(Icons.search_rounded, size: 32, color: Colors.white),
      )
          .padding(all: 12)
          .ripple()
          .decorated(
            color: blueColor,
          )
          .gestures(
            onTap: () {},
          )
          .clipRRect(
            topRight: defaultBorderRadius,
            bottomRight: defaultBorderRadius,
          ),
    ]
        .toRow()
        .decorated(
          color: Colors.white,
          borderRadius: BorderRadius.circular(defaultBorderRadius),
        )
        .elevation(
          12,
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          shadowColor: Colors.black38,
        );
  }
}

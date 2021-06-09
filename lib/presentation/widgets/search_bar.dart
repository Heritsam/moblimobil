import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../core/themes/theme.dart';
import '../../generated/l10n.dart';

class SearchBar extends StatefulWidget {
  final Function(String)? onSearch;
  final Function(String)? onChanged;
  final Function() onTextCleared;

  const SearchBar({
    Key? key,
    this.onSearch,
    this.onChanged,
    required this.onTextCleared,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: S.of(context).search,
            hintStyle: TextStyle(color: mediumGreyColor),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(16),
          ),
          onChanged: widget.onChanged,
        ).expanded(),
        if (_controller.text.isNotEmpty)
          IconButton(
            onPressed: () {
              _controller.clear();
              widget.onTextCleared();
            },
            icon: Icon(Icons.close, size: 18, color: Colors.black54),
          ),
        Icon(Icons.search_rounded, size: 32, color: Colors.white)
            .padding(all: 12)
            .ripple()
            .decorated(
              color: blueColor,
            )
            .gestures(
          onTap: () {
            widget.onSearch!(_controller.text);
          },
        ).clipRRect(
          topRight: defaultBorderRadius,
          bottomRight: defaultBorderRadius,
        ),
      ],
    ).decorated(
      color: lightGreyColor,
      borderRadius: BorderRadius.circular(defaultBorderRadius),
    );
  }
}

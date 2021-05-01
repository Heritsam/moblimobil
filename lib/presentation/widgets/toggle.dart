import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../core/theme.dart';

typedef void ToggleCallback(String value);

class Toggle extends StatelessWidget {
  final List<String> items;
  final String value;
  final ToggleCallback onTap;

  const Toggle({
    Key? key,
    required this.items,
    required this.value,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: lightGreyColor,
      borderRadius: BorderRadius.circular(defaultBorderRadius),
      child: items
          .asMap()
          .entries
          .map((e) {
            String itemValue = e.value;

            return _buildToggleItem(
              onTap: () {
                this.onTap(itemValue);
              },
              isActive: value == itemValue ? true : false,
              label: itemValue,
            );
          })
          .toList()
          .toRow(),
    );
  }

  Widget _buildToggleItem({
    required bool isActive,
    required String label,
    Function()? onTap,
  }) {
    return Material(
      color: isActive ? greenColor : lightGreyColor,
      borderRadius: BorderRadius.circular(defaultBorderRadius),
      elevation: isActive ? 4 : 0,
      shadowColor: isActive ? greenColor.withOpacity(.26) : Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        child: AnimatedContainer(
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          duration: Duration(milliseconds: 250),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : darkGreyColor,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
        ),
      ),
    ).expanded();
  }
}

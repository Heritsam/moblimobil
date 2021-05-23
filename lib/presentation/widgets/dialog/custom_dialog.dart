import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String? description;
  final List<CustomDialogAction>? actions;

  const CustomDialog({
    Key? key,
    required this.title,
    this.description,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(horizontal: 48, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 16,
            ),
          ).padding(top: 24, horizontal: 32),
          if (description != null)
            Text(
              description ?? '',
              textAlign: TextAlign.center,
            ).padding(horizontal: 32, top: 8),
          SizedBox(height: 24),
          if (actions != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: actions?.map((e) {
                    return CupertinoButton(
                      child: Text(
                        e.label,
                        style: TextStyle(
                          color: e.isDestructiveAction ? redColor : greenColor,
                          fontWeight: e.isDefaultAction
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      onPressed: e.onPressed,
                    ).expanded();
                  }).toList() ??
                  [],
            ).decorated(
              border: Border(
                top: BorderSide(color: Colors.black12),
              ),
            ),
        ],
      ),
    );
  }
}

class CustomDialogAction {
  final Function()? onPressed;
  final String label;
  final bool isDefaultAction;
  final bool isDestructiveAction;

  const CustomDialogAction({
    this.onPressed,
    required this.label,
    this.isDefaultAction = false,
    this.isDestructiveAction = false,
  });
}

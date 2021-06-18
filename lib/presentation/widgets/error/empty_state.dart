import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    Key? key,
    required this.message,
    this.onPressed,
    this.buttonLabel = 'Refresh',
  }) : super(key: key);

  final String message;
  final String buttonLabel;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/empty_state.png',
            width: MediaQuery.of(context).size.width / 1.5,
          ),
          Text(
            'Oops!',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: darkGreyColor,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          Text(message, textAlign: TextAlign.center).padding(horizontal: 24),
          SizedBox(height: 16),
          if (onPressed != null)
            TextButton(
              onPressed: onPressed,
              child: Text(buttonLabel),
            ),
          SizedBox(height: 32),
        ],
      ),
    );
  }
}

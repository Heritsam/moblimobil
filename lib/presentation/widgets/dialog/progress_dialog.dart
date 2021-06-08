import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class ProgressDialog extends StatelessWidget {
  const ProgressDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      key: key,
      backgroundColor: Colors.white,
      children: <Widget>[
        Center(
          child: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 24),
              Text('Loading...'),
            ],
          ),
        ).padding(horizontal: 24, vertical: 8),
      ],
    );
  }
}

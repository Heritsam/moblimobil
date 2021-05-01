import 'package:flutter/material.dart';

import '../../../core/theme.dart';
import '../../../generated/l10n.dart';

class NotificationDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
    );
  }
}

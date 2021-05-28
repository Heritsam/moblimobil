import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';

class FeatureDetailArgs {
  final String title;
  final ImageProvider image;

  const FeatureDetailArgs({
    required this.title,
    required this.image,
  });
}

class FeatureDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as FeatureDetailArgs;

    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        centerTitle: false,
        elevation: 0,
        title: Text(
          args.title,
          style: textTheme.headline6!.copyWith(color: darkGreyColor),
        ),
        flexibleSpace: ClipRRect(
          child: Container(color: Colors.white60).backgroundBlur(7),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: mediaQuery.padding.top + 72,
          bottom: mediaQuery.padding.bottom + 32,
          left: 16,
          right: 16,
        ),
        child: Column(
          children: [
            Image(image: args.image, height: 140, width: 140),
            Text(
              args.title.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            SizedBox(height: 24),
            Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
              style: TextStyle(color: darkGreyColor, height: 1.3),
            ),
          ],
        ),
      ),
    );
  }
}

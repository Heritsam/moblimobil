import 'package:flutter/material.dart';
import 'package:moblimobil/presentation/widgets/rounded_button.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/theme.dart';
import '../../../generated/l10n.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final _textNode = FocusNode();

  @override
  void dispose() {
    _textNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white70,
        elevation: 0,
        centerTitle: false,
        title: Text(
          S.of(context).help,
          style: textTheme.headline6?.copyWith(color: darkGreyColor),
        ),
        flexibleSpace: ClipRRect(
          child: Container(color: Colors.white60).backgroundBlur(7),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: mediaQuery.padding.top + 56 + 16,
          left: 16,
          right: 16,
          bottom: 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: S.of(context).fullNameField,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 18),
                hintStyle: TextStyle(color: mediumGreyColor),
              ),
              textInputAction: TextInputAction.next,
              onSubmitted: (value) {
                FocusScope.of(context).requestFocus(_textNode);
              },
            ).decorated(
              color: blueColor.withOpacity(.12),
              borderRadius: BorderRadius.circular(defaultBorderRadius),
            ),
            SizedBox(height: 16),
            TextField(
              focusNode: _textNode,
              decoration: InputDecoration(
                hintText: S.of(context).textField,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 16,
                ),
                hintStyle: TextStyle(color: mediumGreyColor),
              ),
              maxLines: 5,
            ).decorated(
              color: blueColor.withOpacity(.12),
              borderRadius: BorderRadius.circular(defaultBorderRadius),
            ),
            SizedBox(height: 32),
            RoundedButton(
              label: S.of(context).send,
            ),
            SizedBox(height: 32),
            Text(
              S.of(context).otherHelpMessage,
              textAlign: TextAlign.center,
            ).textColor(darkGreyColor.withOpacity(.70)),
            SizedBox(height: 32),
            Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      color: mediumGreyColor,
                      size: 28,
                    ),
                    SizedBox(width: 16),
                    Text(
                      '0822 1353 0065',
                      style: TextStyle(
                        color: greenColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ).expanded()
                  ],
                ).padding(vertical: 16),
                Row(
                  children: [
                    Icon(
                      Icons.mail_outline_rounded,
                      color: mediumGreyColor,
                      size: 28,
                    ),
                    SizedBox(width: 16),
                    Text(
                      'moblimobil@gmail.com',
                      style: TextStyle(
                        color: greenColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ).expanded()
                  ],
                ).padding(vertical: 16),
                Row(
                  children: [
                    Icon(
                      Icons.map_rounded,
                      color: mediumGreyColor,
                      size: 28,
                    ),
                    SizedBox(width: 16),
                    Text(
                      'Jl. Anyelir IV Blok 5W No.4',
                      style: TextStyle(
                        color: greenColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ).expanded()
                  ],
                ).padding(vertical: 16),
              ],
            )
                .padding(all: 16)
                .decorated(
                  color: blueColor.withOpacity(.12),
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                )
                .constrained(width: size.width),
          ],
        ),
      ).gestures(onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      }),
    );
  }
}

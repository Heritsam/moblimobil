import 'package:flutter/material.dart';
import 'package:moblimobil/presentation/widgets/circle_image.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructures/models/car.dart';

class NewsDetailPage extends StatelessWidget {
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
          S.of(context).detail,
          style: textTheme.headline6?.copyWith(color: darkGreyColor),
        ),
        flexibleSpace: ClipRRect(
          child: Container(color: Colors.white60).backgroundBlur(7),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: mediaQuery.padding.top + 56),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Styled.widget()
                .decorated(
                  color: lightGreyColor,
                  image: DecorationImage(
                    image: NetworkImage(carList[2].imageUrl),
                    fit: BoxFit.cover,
                  ),
                )
                .constrained(width: size.width, height: 210),
            SizedBox(height: 24),
            Row(
              children: [
                CircleImage(
                  image: NetworkImage(
                      'https://uifaces.co/our-content/donated/gPZwCbdS.jpg'),
                  size: 28,
                ),
                SizedBox(width: 8),
                Text(
                  'Iustiar | 2 Jam yang lalu',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: mediumGreyColor,
                    fontWeight: FontWeight.w500,
                  ),
                ).expanded(),
                InkResponse(
                  onTap: () {},
                  child: Icon(Icons.bookmark_border_rounded),
                ),
              ],
            ).padding(horizontal: 16),
            SizedBox(height: 32),
            Text(
              'Lorem Ipsum',
              style: TextStyle(
                color: darkGreyColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ).padding(horizontal: 16),
            SizedBox(height: 16),
            Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
            ).padding(horizontal: 16),
          ],
        ),
      ),
    );
  }
}

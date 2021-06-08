import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../widgets/cars/car_card.dart';
import '../../widgets/error/empty_state.dart';
import '../../widgets/mobli_chip.dart';
import '../../widgets/search_bar.dart';
import 'compare_nav.dart';
import 'modals/sort_and_filter.dart';
import 'viewmodels/car_compare_viewmodel.dart';

class CarsPage extends StatefulWidget {
  const CarsPage({Key? key}) : super(key: key);

  @override
  _CarsPageState createState() => _CarsPageState();
}

class _CarsPageState extends State<CarsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
        centerTitle: false,
        flexibleSpace: ClipRRect(
          child: Container(color: Colors.white60).backgroundBlur(7),
        ),
        title: Text(
          S.of(context).compare,
          style: TextStyle(color: darkGreyColor, fontWeight: FontWeight.w700),
        ),
      ),
      bottomNavigationBar: CompareNav(),
      body: RefreshIndicator(
        onRefresh: () async {
          Future.wait([
            context.read(carCompareViewModel).resetAndFetch(),
          ]);
        },
        displacement: 32 + mediaQuery.padding.top,
        edgeOffset: 32 + mediaQuery.padding.top,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: mediaQuery.padding.top + 56 + 16,
            bottom: 32,
          ),
          physics: BouncingScrollPhysics(),
          child: <Widget>[
            SearchBar(
              onChanged: context.read(carCompareViewModel).changeSearchText,
              onSearch: (_) {
                context.read(carCompareViewModel).fetch();
              },
            ).padding(horizontal: 16),
            SizedBox(height: 32),
            Text(S.of(context).category, style: textTheme.headline6)
                .padding(horizontal: 16),
            SizedBox(height: 12),
            ListView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                MobliChip(
                  label: S.of(context).popular,
                  selected: true,
                ).padding(right: 12, bottom: 24),
                MobliChip(
                  onTap: () {},
                  label: S.of(context).justReleased,
                  selected: false,
                  elevated: false,
                ).padding(right: 12, bottom: 24),
                MobliChip(
                  onTap: () {},
                  label: S.of(context).comingSoon,
                  selected: false,
                  elevated: false,
                ).padding(right: 12, bottom: 24),
              ],
            ).constrained(height: 64),
            SizedBox(height: 4),
            InkResponse(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => SortAndFilter(),
                );
              },
              child: Text(
                S.of(context).sortAndFilter,
                style: TextStyle(
                  color: blueColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ).padding(horizontal: 16),
            ),
            Consumer(
              builder: (context, watch, child) {
                final vm = watch(carCompareViewModel);

                return vm.carsState.when(
                  initial: () => _Jerangkong(),
                  loading: () => _Jerangkong(),
                  error: (message) {
                    return EmptyState(
                      onPressed: vm.fetch,
                      message: message,
                    );
                  },
                  data: (cars) {
                    return GridView.builder(
                      padding: EdgeInsets.only(
                        top: 16,
                        left: 16,
                        right: 16,
                        bottom: 24,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 3.3 / 4.3,
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: cars.length,
                      itemBuilder: (context, index) {
                        final item = cars[index];

                        return CarCard(
                          onTap: () {
                            context
                                .read(carCompareViewModel)
                                .addCar(context: context, car: item);
                          },
                          carId: item.id,
                          hasUsed: item.type == 'used',
                          title: '${item.brandName} ${item.title}',
                          price: int.tryParse(item.price) ?? 0,
                          imageUrl: item.file.isNotEmpty
                              ? item.file.first.file
                              : 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/600px-No_image_available.svg.png',
                          size: mediaQuery.size.width / 2 - 24,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
        ),
      ),
    );
  }
}

class _Jerangkong extends StatelessWidget {
  const _Jerangkong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return GridView.builder(
      padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 24),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 3.3 / 4.3,
      ),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: lightGreyColor,
          highlightColor: Colors.white24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: mediaQuery.size.width / 2 - 24,
                width: mediaQuery.size.width / 2 - 24,
                decoration: BoxDecoration(
                  color: lightGreyColor,
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 16,
                width: mediaQuery.size.width / 3,
                decoration: BoxDecoration(
                  color: lightGreyColor,
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                ),
              ),
              SizedBox(height: 8),
              Container(
                height: 14,
                width: mediaQuery.size.width / 1.2,
                decoration: BoxDecoration(
                  color: lightGreyColor,
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

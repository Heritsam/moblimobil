import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/mobli_icons_icons.dart';
import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../notifiers/authentication/authentication_notifier.dart';
import '../../widgets/cars/car_card.dart';
import '../../widgets/error/empty_state.dart';
import '../../widgets/mobli_chip.dart';
import '../../widgets/search_bar.dart';
import '../cars_detail/cars_detail_page.dart';
import 'modals/search_sort.dart';
import 'viewmodels/search_viewmodel.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white70,
        elevation: 0,
        centerTitle: false,
        flexibleSpace: ClipRRect(
          child: Container(color: Colors.white60).backgroundBlur(7),
        ),
        title: Text(
          S.of(context).explore,
          style: TextStyle(color: darkGreyColor, fontWeight: FontWeight.w700),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => SearchSort(),
          );
        },
        label: Text('Sort & Filter', style: TextStyle(color: darkGreyColor)),
        icon: Icon(MobliIcons.sort_and_filter, color: darkGreyColor),
        backgroundColor: Colors.white,
      ).padding(bottom: mediaQuery.padding.bottom),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Consumer(
        builder: (context, watch, child) {
          final authState = watch(authenticationNotifier);
          final vm = watch(searchViewModel);

          return RefreshIndicator(
            onRefresh: () async {
              Future.wait([
                vm.initializeSort(),
                vm.search(),
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
                  onChanged: vm.changeSearchText,
                  onSearch: (_) {
                    vm.search();
                  },
                  onTextCleared: vm.resetAndSearch,
                ).padding(horizontal: 16),
                SizedBox(height: 32),
                Text(S.of(context).category, style: textTheme.headline6)
                    .padding(horizontal: 16),
                SizedBox(height: 16),
                ListView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    MobliChip(
                      onTap: () {
                        vm.changeCategory('');
                      },
                      label: S.of(context).forYou,
                      selected: vm.type == '',
                      elevated: vm.type == '',
                    ).padding(right: 12, bottom: 24),
                    authState.maybeWhen(
                      authenticated: () {
                        return MobliChip(
                          onTap: () {
                            Navigator.pushNamed(context, '/search-recent');
                          },
                          label: S.of(context).recentlySeen,
                          selected: false,
                          elevated: false,
                        ).padding(right: 12, bottom: 24);
                      },
                      orElse: () {
                        return SizedBox();
                      },
                    ),
                    MobliChip(
                      onTap: () {
                        vm.changeCategory('new');
                      },
                      label: S.of(context).newCars,
                      selected: vm.type == 'new',
                      elevated: vm.type == 'new',
                    ).padding(right: 12, bottom: 24),
                    MobliChip(
                      onTap: () {
                        vm.changeCategory('used');
                      },
                      label: S.of(context).usedCars,
                      selected: vm.type == 'used',
                      elevated: vm.type == 'used',
                    ).padding(right: 12, bottom: 24),
                  ],
                ).constrained(height: 64),
                vm.carState.when(
                  initial: () => _Jerangkong(),
                  loading: () => _Jerangkong(),
                  error: (message) {
                    return EmptyState(
                      onPressed: message == 'notfound'
                          ? null
                          : () {
                              vm.search();
                            },
                      message: message,
                    );
                  },
                  data: (cars) {
                    return GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16),
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
                            Navigator.pushNamed(
                              context,
                              '/cars-detail',
                              arguments: CarsDetailArgs(item.id),
                            );
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
                ),
                SizedBox(height: 80 + mediaQuery.padding.top),
              ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
            ),
          );
        },
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

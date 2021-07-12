import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../widgets/error/empty_state.dart';
import '../../widgets/mobli_card.dart';
import 'viewmodels/iuran_history_viewmodel.dart';

class IuranHistoryPage extends StatefulWidget {
  @override
  _IuranHistoryPageState createState() => _IuranHistoryPageState();
}

class _IuranHistoryPageState extends State<IuranHistoryPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      context.read(iuranHistoryViewModel).fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
        centerTitle: false,
        flexibleSpace: ClipRRect(
          child: Container(color: Colors.white60).backgroundBlur(7),
        ),
        title: Text(
          'History',
          style: TextStyle(color: darkGreyColor, fontWeight: FontWeight.w700),
        ),
      ),
      body: Consumer(
        builder: (context, watch, child) {
          final vm = watch(iuranHistoryViewModel);

          return vm.iuranState.when(
            initial: () => _Jerangkong(),
            loading: () => _Jerangkong(),
            error: (message) {
              return EmptyState(
                onPressed: vm.fetch,
                message: message,
              );
            },
            data: (items) {
              return RefreshIndicator(
                onRefresh: () async {
                  Future.wait([
                    vm.fetch(),
                  ]);
                },
                displacement: mediaQuery.padding.top,
                edgeOffset: mediaQuery.padding.top,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  padding: EdgeInsets.only(
                    top: mediaQuery.padding.top + 72,
                    bottom: mediaQuery.padding.bottom + 64,
                    left: 16,
                    right: 16,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];

                    return Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: MobliCard(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                color: lightGreyColor,
                                borderRadius:
                                    BorderRadius.circular(defaultBorderRadius),
                                image: DecorationImage(
                                  image: NetworkImage(item.file),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.typeFee,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  DateFormat('dd/MM/yyyy')
                                      .format(item.createdAt),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: redColor,
                                  ),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  item.bankName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: blueColor,
                                  ),
                                ),
                                Text(
                                  item.detailName,
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  NumberFormat.currency(
                                    locale: 'id',
                                    decimalDigits: 0,
                                    symbol: 'Rp ',
                                  ).format(int.parse(item.fee)),
                                  style: TextStyle(
                                    color: greenColor,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ).expanded(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
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
    final size = mediaQuery.size;

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(
        top: mediaQuery.padding.top + 16,
        bottom: mediaQuery.padding.bottom + 16,
        left: 16,
        right: 16,
      ),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: MobliCard(
            padding: EdgeInsets.all(16),
            child: Shimmer.fromColors(
              baseColor: lightGreyColor,
              highlightColor: Colors.white24,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: lightGreyColor,
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 16,
                        width: size.width / 2,
                        decoration: BoxDecoration(
                          color: lightGreyColor,
                          borderRadius:
                              BorderRadius.circular(defaultBorderRadius),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: 14,
                        width: size.width / 3,
                        decoration: BoxDecoration(
                          color: lightGreyColor,
                          borderRadius:
                              BorderRadius.circular(defaultBorderRadius),
                        ),
                      ),
                      SizedBox(height: 40),
                      Container(
                        height: 22,
                        width: size.width / 2.3,
                        decoration: BoxDecoration(
                          color: lightGreyColor,
                          borderRadius:
                              BorderRadius.circular(defaultBorderRadius),
                        ),
                      ),
                    ],
                  ).expanded(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

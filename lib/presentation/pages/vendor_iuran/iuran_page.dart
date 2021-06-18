import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:moblimobil/presentation/pages/account/viewmodels/account_user_notifier.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../../core/themes/theme.dart';
import '../../../generated/l10n.dart';
import '../../widgets/buttons/rounded_button.dart';
import '../../widgets/error/empty_state.dart';
import '../../widgets/mobli_loading_indicator.dart';
import 'viewmodels/bank_account_notifier.dart';

class IuranPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
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
          S.of(context).iuran,
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/iuran-history');
            },
            icon: Icon(Icons.history, color: mediumGreyColor),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Future.wait([
            context.read(bankAccountNotifier).fetch(),
          ]);
        },
        displacement: mediaQuery.padding.top + 72,
        edgeOffset: mediaQuery.padding.top + 32,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            top: mediaQuery.padding.top + 72,
            bottom: mediaQuery.padding.bottom + 32,
            left: 16,
            right: 16,
          ),
          child: Consumer(builder: (context, watch, child) {
            final accountNotifier = watch(accountUserNotifier);
            final bankNotifier = watch(bankAccountNotifier);

            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Iuran anda selanjutnya',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: mediumGreyColor,
                        fontSize: 16,
                      ),
                    ).expanded(flex: 2),
                    Text(
                      accountNotifier.userState.maybeWhen(
                        data: (user) {
                          return DateFormat('dd/MM/yyyy')
                              .format(user.monthlyContrBill!);
                        },
                        orElse: () => '-',
                      ),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: greenColor,
                        fontSize: 16,
                      ),
                    ).expanded(),
                  ],
                )
                    .padding(
                      all: 16,
                    )
                    .decorated(
                      border: Border.all(color: mediumGreyColor, width: 1),
                      borderRadius: BorderRadius.circular(defaultBorderRadius),
                    ),
                SizedBox(height: 32),
                Text(
                  'Iuran bulanan sebesar',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Rp 123.000',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: greenColor,
                      ),
                    ),
                    Text(
                      ' / ',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: mediumGreyColor,
                      ),
                    ),
                    Text(
                      '3 Month',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: mediumGreyColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Rp 234.000',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: greenColor,
                      ),
                    ),
                    Text(
                      ' / ',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: mediumGreyColor,
                      ),
                    ),
                    Text(
                      '6 Month',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: mediumGreyColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Rp 345.000',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: greenColor,
                      ),
                    ),
                    Text(
                      ' / ',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: mediumGreyColor,
                      ),
                    ),
                    Text(
                      '12 Month',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: mediumGreyColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                  style: TextStyle(color: mediumGreyColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32),
                Row(
                  children: [
                    Text(S.of(context).paymentMethod,
                        style: textTheme.headline6),
                  ],
                ),
                SizedBox(height: 12),
                bankNotifier.bankState.when(
                  initial: () => MobliLoadingIndicator(),
                  loading: () => MobliLoadingIndicator(),
                  error: (message) {
                    return EmptyState(
                      onPressed: bankNotifier.fetch,
                      message: message,
                    );
                  },
                  data: (items) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(0),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item.bankName,
                                  style: TextStyle(
                                    color: blueColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                InkResponse(
                                  onTap: () {
                                    FlutterClipboard.copy(item.accountNumber)
                                        .then((value) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text('Copied!')));
                                    });
                                  },
                                  child: Text(
                                    'Copy No. Rek',
                                    style: TextStyle(
                                      color: blueColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              item.atasNama,
                              style: TextStyle(
                                color: darkGreyColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              item.accountNumber,
                              style: TextStyle(
                                color: greenColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        )
                            .padding(
                              all: 16,
                            )
                            .decorated(
                              border:
                                  Border.all(width: 1, color: mediumGreyColor),
                              borderRadius:
                                  BorderRadius.circular(defaultBorderRadius),
                            )
                            .padding(bottom: 16);
                      },
                    );
                  },
                ),
                SizedBox(height: 32),
                RoundedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/pay-iuran');
                  },
                  label: 'Bayar Iuran',
                ),
                SizedBox(height: 32),
              ],
            );
          }),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moblimobil/wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/theme.dart';
import 'generated/l10n.dart';
import 'presentation/notifiers/app_settings/app_settings_notifier.dart';
import 'presentation/pages/about/about_page.dart';
import 'presentation/pages/account/account_page.dart';
import 'presentation/pages/account/change_password_page.dart';
import 'presentation/pages/account/edit_profile_page.dart';
import 'presentation/pages/authentication/forgot_password_page.dart';
import 'presentation/pages/authentication/login_page.dart';
import 'presentation/pages/authentication/register_page.dart';
import 'presentation/pages/cars/cars_compare_detail_page.dart';
import 'presentation/pages/cars/cars_page.dart';
import 'presentation/pages/cars_detail/cars_detail_page.dart';
import 'presentation/pages/faq/faq_page.dart';
import 'presentation/pages/help/help_page.dart';
import 'presentation/pages/home/home_page.dart';
import 'presentation/pages/news/news_and_review_page.dart';
import 'presentation/pages/news/news_detail_page.dart';
import 'presentation/pages/news/news_list_page.dart';
import 'presentation/pages/notification/notification_detail_page.dart';
import 'presentation/pages/notification/notification_page.dart';
import 'presentation/pages/search/search_page.dart';
import 'presentation/pages/wishlist/wishlist_page.dart';
import 'providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();

  runApp(ProviderScope(
    overrides: [
      sharedPreferences.overrideWithValue(preferences),
    ],
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final settings = watch(appSettingsNotifier);

    return MaterialApp(
      title: 'MobliMobil',
      locale: Locale(settings.language),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        primaryColor: blueColor,
        accentColor: darkGreyColor,
        textTheme: GoogleFonts.montserratTextTheme().copyWith(
          button: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.0,
          ),
          headline6: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: darkGreyColor,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Wrapper(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/forgot-password': (context) => ForgotPasswordPage(),
        '/home': (context) => HomePage(),
        '/notification': (context) => NotificationPage(),
        '/notification-detail': (context) => NotificationDetailPage(),
        '/search': (context) => SearchPage(),
        '/new-cars': (context) => CarsPage(type: CarsPageType.newCars),
        '/used-cars': (context) => CarsPage(type: CarsPageType.usedCars),
        '/discount': (context) => CarsPage(type: CarsPageType.discount),
        '/cars-detail': (context) => CarsDetailPage(),
        '/compare': (context) => CarsPage(type: CarsPageType.compare),
        '/compare-detail': (context) => CarsCompareDetailPage(),
        '/news-and-review': (context) => NewsAndReviewPage(),
        '/news-list': (context) => NewsListPage(type: NewsListPageType.news),
        '/reviews-list': (context) =>
            NewsListPage(type: NewsListPageType.reviews),
        '/news-detail': (context) => NewsDetailPage(),
        '/faq': (context) => FaqPage(),
        '/account': (context) => AccountPage(),
        '/help': (context) => HelpPage(),
        '/about': (context) => AboutPage(),
        '/change-password': (context) => ChangePasswordPage(),
        '/edit-profile': (context) => EditProfilePage(),
        '/wishlist': (context) => WishlistPage(),
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/themes/theme.dart';
import 'generated/l10n.dart';
import 'presentation/notifiers/app_settings/app_settings_notifier.dart';
import 'presentation/pages/about/about_page.dart';
import 'presentation/pages/account/account_page.dart';
import 'presentation/pages/account/edit_profile_page.dart';
import 'presentation/pages/authentication/forgot_password_page.dart';
import 'presentation/pages/authentication/login_page.dart';
import 'presentation/pages/authentication/otp_page.dart';
import 'presentation/pages/authentication/register_page.dart';
import 'presentation/pages/cars/cars_compare_detail_page.dart';
import 'presentation/pages/cars/cars_page.dart';
import 'presentation/pages/cars_detail/cars_detail_page.dart';
import 'presentation/pages/change_password/change_password_page.dart';
import 'presentation/pages/faq/faq_page.dart';
import 'presentation/pages/help/help_page.dart';
import 'presentation/pages/main_page.dart';
import 'presentation/pages/news/news_and_review_page.dart';
import 'presentation/pages/news/news_detail_page.dart';
import 'presentation/pages/news/news_list_page.dart';
import 'presentation/pages/notification/notification_detail_page.dart';
import 'presentation/pages/notification/notification_page.dart';
import 'presentation/pages/onboarding_page.dart';
import 'presentation/pages/search/search_page.dart';
import 'presentation/pages/search/search_recent_page.dart';
import 'presentation/pages/vendor/vendor_sold_page.dart';
import 'presentation/pages/vendor_cars/vendor_cars_detail_page.dart';
import 'presentation/pages/vendor_cars/vendor_cars_page.dart';
import 'presentation/pages/video/video_page.dart';
import 'presentation/pages/wishlist/wishlist_page.dart';
import 'providers.dart';
import 'wrapper.dart';

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
      title: 'LakuMobil',
      locale: Locale(settings.language),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.cyan,
        primaryColor: blueColor,
        accentColor: darkGreyColor,
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
          button: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
          ),
          headline6: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: darkGreyColor,
          ),
          bodyText1: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Wrapper(),
        '/onboarding': (context) => OnboardingPage(),
        '/login': (context) => LoginPage(),
        '/otp': (context) => OtpPage(),
        '/register': (context) => RegisterPage(),
        '/forgot-password': (context) => ForgotPasswordPage(),
        '/home': (context) => MainPage(),
        '/notification': (context) => NotificationPage(),
        '/notification-detail': (context) => NotificationDetailPage(),
        '/search': (context) => SearchPage(),
        '/search-recent': (context) => SearchRecentPage(),
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
        '/videos': (context) => VideoPage(),
        '/vendor-sold': (context) => VendorSoldPage(),
        '/vendor-cars': (context) => VendorCarsPage(),
        '/vendor-cars-detail': (context) => VendorCarsDetailPage(),
      },
    );
  }
}

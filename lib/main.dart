import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/theme.dart';
import 'generated/l10n.dart';
import 'presentation/notifiers/app_settings/app_settings_notifier.dart';
import 'presentation/pages/authentication/forgot_password_page.dart';
import 'presentation/pages/authentication/login_page.dart';
import 'presentation/pages/home/home_page.dart';
import 'presentation/pages/notification/notification_detail_page.dart';
import 'presentation/pages/notification/notification_page.dart';
import 'presentation/pages/authentication/register_page.dart';
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
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/forgot-password': (context) => ForgotPasswordPage(),
        '/home': (context) => HomePage(),
        '/notification': (context) => NotificationPage(),
        '/notification-detail': (context) => NotificationDetailPage(),
      },
    );
  }
}

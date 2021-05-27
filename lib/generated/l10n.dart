// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `See All`
  String get seeAll {
    return Intl.message(
      'See All',
      name: 'seeAll',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcomeText {
    return Intl.message(
      'Welcome',
      name: 'welcomeText',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skipText {
    return Intl.message(
      'Skip',
      name: 'skipText',
      desc: '',
      args: [],
    );
  }

  /// `Enter phone number`
  String get phoneField {
    return Intl.message(
      'Enter phone number',
      name: 'phoneField',
      desc: '',
      args: [],
    );
  }

  /// `Enter password`
  String get passwordField {
    return Intl.message(
      'Enter password',
      name: 'passwordField',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Remember Me`
  String get rememberMe {
    return Intl.message(
      'Remember Me',
      name: 'rememberMe',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Later`
  String get later {
    return Intl.message(
      'Later',
      name: 'later',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message(
      'or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Login with Google`
  String get loginWithGoogle {
    return Intl.message(
      'Login with Google',
      name: 'loginWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to logout?`
  String get logoutMessage {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'logoutMessage',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Enter name`
  String get fullNameField {
    return Intl.message(
      'Enter name',
      name: 'fullNameField',
      desc: '',
      args: [],
    );
  }

  /// `We will help you reset your password\nby sending us your email address.`
  String get forgotPasswordMessage {
    return Intl.message(
      'We will help you reset your password\nby sending us your email address.',
      name: 'forgotPasswordMessage',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Not receiving code?`
  String get notReceiveCode {
    return Intl.message(
      'Not receiving code?',
      name: 'notReceiveCode',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get resendCode {
    return Intl.message(
      'Resend Code',
      name: 'resendCode',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Enter email address`
  String get emailField {
    return Intl.message(
      'Enter email address',
      name: 'emailField',
      desc: '',
      args: [],
    );
  }

  /// `New Cars`
  String get newCars {
    return Intl.message(
      'New Cars',
      name: 'newCars',
      desc: '',
      args: [],
    );
  }

  /// `Used Cars`
  String get usedCars {
    return Intl.message(
      'Used Cars',
      name: 'usedCars',
      desc: '',
      args: [],
    );
  }

  /// `Used`
  String get usedText {
    return Intl.message(
      'Used',
      name: 'usedText',
      desc: '',
      args: [],
    );
  }

  /// `Compare`
  String get compare {
    return Intl.message(
      'Compare',
      name: 'compare',
      desc: '',
      args: [],
    );
  }

  /// `News & Review`
  String get newsAndReview {
    return Intl.message(
      'News & Review',
      name: 'newsAndReview',
      desc: '',
      args: [],
    );
  }

  /// `Hot Deals`
  String get hotDeals {
    return Intl.message(
      'Hot Deals',
      name: 'hotDeals',
      desc: '',
      args: [],
    );
  }

  /// `Popular Cars`
  String get popularCars {
    return Intl.message(
      'Popular Cars',
      name: 'popularCars',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Search for Cars by Location`
  String get searchByLocation {
    return Intl.message(
      'Search for Cars by Location',
      name: 'searchByLocation',
      desc: '',
      args: [],
    );
  }

  /// `Search for Cars by Brand`
  String get searchByBrand {
    return Intl.message(
      'Search for Cars by Brand',
      name: 'searchByBrand',
      desc: '',
      args: [],
    );
  }

  /// `Videos`
  String get videos {
    return Intl.message(
      'Videos',
      name: 'videos',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Explore`
  String get explore {
    return Intl.message(
      'Explore',
      name: 'explore',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Discount & Promo`
  String get discountAndPromo {
    return Intl.message(
      'Discount & Promo',
      name: 'discountAndPromo',
      desc: '',
      args: [],
    );
  }

  /// `Insurance`
  String get insurance {
    return Intl.message(
      'Insurance',
      name: 'insurance',
      desc: '',
      args: [],
    );
  }

  /// `Credit`
  String get credit {
    return Intl.message(
      'Credit',
      name: 'credit',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Detail`
  String get detail {
    return Intl.message(
      'Detail',
      name: 'detail',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `For You`
  String get forYou {
    return Intl.message(
      'For You',
      name: 'forYou',
      desc: '',
      args: [],
    );
  }

  /// `Just Released`
  String get justReleased {
    return Intl.message(
      'Just Released',
      name: 'justReleased',
      desc: '',
      args: [],
    );
  }

  /// `Coming Soon`
  String get comingSoon {
    return Intl.message(
      'Coming Soon',
      name: 'comingSoon',
      desc: '',
      args: [],
    );
  }

  /// `Recently Seen`
  String get recentlySeen {
    return Intl.message(
      'Recently Seen',
      name: 'recentlySeen',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Search for cars`
  String get searchForCars {
    return Intl.message(
      'Search for cars',
      name: 'searchForCars',
      desc: '',
      args: [],
    );
  }

  /// `Search Result`
  String get searchResult {
    return Intl.message(
      'Search Result',
      name: 'searchResult',
      desc: '',
      args: [],
    );
  }

  /// `Popular`
  String get popular {
    return Intl.message(
      'Popular',
      name: 'popular',
      desc: '',
      args: [],
    );
  }

  /// `Sort & Filter`
  String get sortAndFilter {
    return Intl.message(
      'Sort & Filter',
      name: 'sortAndFilter',
      desc: '',
      args: [],
    );
  }

  /// `Sorting`
  String get sorting {
    return Intl.message(
      'Sorting',
      name: 'sorting',
      desc: '',
      args: [],
    );
  }

  /// `Installment`
  String get installment {
    return Intl.message(
      'Installment',
      name: 'installment',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Body Type`
  String get bodyType {
    return Intl.message(
      'Body Type',
      name: 'bodyType',
      desc: '',
      args: [],
    );
  }

  /// `Brand`
  String get brand {
    return Intl.message(
      'Brand',
      name: 'brand',
      desc: '',
      args: [],
    );
  }

  /// `Fuel Type`
  String get fuelType {
    return Intl.message(
      'Fuel Type',
      name: 'fuelType',
      desc: '',
      args: [],
    );
  }

  /// `Transmission`
  String get transmission {
    return Intl.message(
      'Transmission',
      name: 'transmission',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get year {
    return Intl.message(
      'Year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `Kilometers`
  String get kilometers {
    return Intl.message(
      'Kilometers',
      name: 'kilometers',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get color {
    return Intl.message(
      'Color',
      name: 'color',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get month {
    return Intl.message(
      'Month',
      name: 'month',
      desc: '',
      args: [],
    );
  }

  /// `Car Detail`
  String get carDetail {
    return Intl.message(
      'Car Detail',
      name: 'carDetail',
      desc: '',
      args: [],
    );
  }

  /// `Contact Seller`
  String get contactSeller {
    return Intl.message(
      'Contact Seller',
      name: 'contactSeller',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Credit Simulation`
  String get creditSimulation {
    return Intl.message(
      'Credit Simulation',
      name: 'creditSimulation',
      desc: '',
      args: [],
    );
  }

  /// `Recommended`
  String get recommended {
    return Intl.message(
      'Recommended',
      name: 'recommended',
      desc: '',
      args: [],
    );
  }

  /// `Schedule to test drive`
  String get scheduleToTestDrive {
    return Intl.message(
      'Schedule to test drive',
      name: 'scheduleToTestDrive',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get paymentMethod {
    return Intl.message(
      'Payment Method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `News Updates`
  String get newsUpdates {
    return Intl.message(
      'News Updates',
      name: 'newsUpdates',
      desc: '',
      args: [],
    );
  }

  /// `Review Updates`
  String get reviewUpdates {
    return Intl.message(
      'Review Updates',
      name: 'reviewUpdates',
      desc: '',
      args: [],
    );
  }

  /// `News`
  String get news {
    return Intl.message(
      'News',
      name: 'news',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get reviews {
    return Intl.message(
      'Reviews',
      name: 'reviews',
      desc: '',
      args: [],
    );
  }

  /// `Email hasn't been verified yet`
  String get emailVerificationMessage {
    return Intl.message(
      'Email hasn\'t been verified yet',
      name: 'emailVerificationMessage',
      desc: '',
      args: [],
    );
  }

  /// `Wishlist`
  String get wishlist {
    return Intl.message(
      'Wishlist',
      name: 'wishlist',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message(
      'Help',
      name: 'help',
      desc: '',
      args: [],
    );
  }

  /// `Contributor`
  String get contributor {
    return Intl.message(
      'Contributor',
      name: 'contributor',
      desc: '',
      args: [],
    );
  }

  /// `Sell Cars`
  String get sellCar {
    return Intl.message(
      'Sell Cars',
      name: 'sellCar',
      desc: '',
      args: [],
    );
  }

  /// `Advertisement`
  String get advertisement {
    return Intl.message(
      'Advertisement',
      name: 'advertisement',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get aboutUs {
    return Intl.message(
      'About Us',
      name: 'aboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Change Email & Password`
  String get changePhoneAndPassword {
    return Intl.message(
      'Change Email & Password',
      name: 'changePhoneAndPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter text`
  String get textField {
    return Intl.message(
      'Enter text',
      name: 'textField',
      desc: '',
      args: [],
    );
  }

  /// `Or, contact us directly to:`
  String get otherHelpMessage {
    return Intl.message(
      'Or, contact us directly to:',
      name: 'otherHelpMessage',
      desc: '',
      args: [],
    );
  }

  /// `Enter your old phone number & password`
  String get enterOldPasswordPhone {
    return Intl.message(
      'Enter your old phone number & password',
      name: 'enterOldPasswordPhone',
      desc: '',
      args: [],
    );
  }

  /// `Enter your new phone number & password`
  String get enterNewPasswordPhone {
    return Intl.message(
      'Enter your new phone number & password',
      name: 'enterNewPasswordPhone',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Select Gender`
  String get selectGender {
    return Intl.message(
      'Select Gender',
      name: 'selectGender',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Pick birthdate`
  String get birthField {
    return Intl.message(
      'Pick birthdate',
      name: 'birthField',
      desc: '',
      args: [],
    );
  }

  /// `Select province`
  String get selectProvince {
    return Intl.message(
      'Select province',
      name: 'selectProvince',
      desc: '',
      args: [],
    );
  }

  /// `Select city / district`
  String get selectCity {
    return Intl.message(
      'Select city / district',
      name: 'selectCity',
      desc: '',
      args: [],
    );
  }

  /// `Select sub-district`
  String get selectSubDistrict {
    return Intl.message(
      'Select sub-district',
      name: 'selectSubDistrict',
      desc: '',
      args: [],
    );
  }

  /// `Enter address`
  String get addressField {
    return Intl.message(
      'Enter address',
      name: 'addressField',
      desc: '',
      args: [],
    );
  }

  /// `Enter zip code`
  String get zipCodeField {
    return Intl.message(
      'Enter zip code',
      name: 'zipCodeField',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Newest`
  String get newest {
    return Intl.message(
      'Newest',
      name: 'newest',
      desc: '',
      args: [],
    );
  }

  /// `Saved News & Review`
  String get savedNewsAndReview {
    return Intl.message(
      'Saved News & Review',
      name: 'savedNewsAndReview',
      desc: '',
      args: [],
    );
  }

  /// `Cars`
  String get cars {
    return Intl.message(
      'Cars',
      name: 'cars',
      desc: '',
      args: [],
    );
  }

  /// `Sold`
  String get sold {
    return Intl.message(
      'Sold',
      name: 'sold',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Fee`
  String get iuran {
    return Intl.message(
      'Monthly Fee',
      name: 'iuran',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'id'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

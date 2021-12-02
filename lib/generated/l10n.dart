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

  /// `Nourah`
  String get name {
    return Intl.message(
      'Nourah',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Hello with our families`
  String get hello {
    return Intl.message(
      'Hello with our families',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `cart`
  String get cart {
    return Intl.message(
      'cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `alerts`
  String get notifications {
    return Intl.message(
      'alerts',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `home`
  String get home {
    return Intl.message(
      'home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `ordres`
  String get orders {
    return Intl.message(
      'ordres',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `profile`
  String get profile {
    return Intl.message(
      'profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `productå`
  String get product {
    return Intl.message(
      'productå',
      name: 'product',
      desc: '',
      args: [],
    );
  }

  /// `please enter your personal image`
  String get pleaseEnterYourPersonalImage {
    return Intl.message(
      'please enter your personal image',
      name: 'pleaseEnterYourPersonalImage',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get myprofile {
    return Intl.message(
      'My Profile',
      name: 'myprofile',
      desc: '',
      args: [],
    );
  }

  /// `faq`
  String get faq {
    return Intl.message(
      'faq',
      name: 'faq',
      desc: '',
      args: [],
    );
  }

  /// `share with friends`
  String get share {
    return Intl.message(
      'share with friends',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `rate our application`
  String get rateApp {
    return Intl.message(
      'rate our application',
      name: 'rateApp',
      desc: '',
      args: [],
    );
  }

  /// `Contact With Us`
  String get contactWithUs {
    return Intl.message(
      'Contact With Us',
      name: 'contactWithUs',
      desc: '',
      args: [],
    );
  }

  /// `email Us`
  String get emailUs {
    return Intl.message(
      'email Us',
      name: 'emailUs',
      desc: '',
      args: [],
    );
  }

  /// `our terms`
  String get termsandcondions {
    return Intl.message(
      'our terms',
      name: 'termsandcondions',
      desc: '',
      args: [],
    );
  }

  /// `about us`
  String get info {
    return Intl.message(
      'about us',
      name: 'info',
      desc: '',
      args: [],
    );
  }

  /// `There is no products in this location`
  String get thereIsnoProductsInThislocation {
    return Intl.message(
      'There is no products in this location',
      name: 'thereIsnoProductsInThislocation',
      desc: '',
      args: [],
    );
  }

  /// `There is no families in this location`
  String get thereIsnoFamiliesInThislocation {
    return Intl.message(
      'There is no families in this location',
      name: 'thereIsnoFamiliesInThislocation',
      desc: '',
      args: [],
    );
  }

  /// `log out`
  String get logout {
    return Intl.message(
      'log out',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `sign up as family`
  String get signupfamily {
    return Intl.message(
      'sign up as family',
      name: 'signupfamily',
      desc: '',
      args: [],
    );
  }

  /// `sign up as driver`
  String get signupdriver {
    return Intl.message(
      'sign up as driver',
      name: 'signupdriver',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get infoTitle {
    return Intl.message(
      'My Profile',
      name: 'infoTitle',
      desc: '',
      args: [],
    );
  }

  /// `user name`
  String get labelnameinfo {
    return Intl.message(
      'user name',
      name: 'labelnameinfo',
      desc: '',
      args: [],
    );
  }

  /// `phone`
  String get labephoneNumberinfo {
    return Intl.message(
      'phone',
      name: 'labephoneNumberinfo',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailinfo {
    return Intl.message(
      'Email',
      name: 'emailinfo',
      desc: '',
      args: [],
    );
  }

  /// `save`
  String get saveinfo {
    return Intl.message(
      'save',
      name: 'saveinfo',
      desc: '',
      args: [],
    );
  }

  /// `wallet`
  String get walletInfo {
    return Intl.message(
      'wallet',
      name: 'walletInfo',
      desc: '',
      args: [],
    );
  }

  /// `sign up`
  String get register_title {
    return Intl.message(
      'sign up',
      name: 'register_title',
      desc: '',
      args: [],
    );
  }

  /// `family name`
  String get register_family_name {
    return Intl.message(
      'family name',
      name: 'register_family_name',
      desc: '',
      args: [],
    );
  }

  /// `phone`
  String get register_family_number {
    return Intl.message(
      'phone',
      name: 'register_family_number',
      desc: '',
      args: [],
    );
  }

  /// `email`
  String get register_family_email {
    return Intl.message(
      'email',
      name: 'register_family_email',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `have An Account ?`
  String get haveAnAccount {
    return Intl.message(
      'have An Account ?',
      name: 'haveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `dont have An Account ?`
  String get donthaveAnAccount {
    return Intl.message(
      'dont have An Account ?',
      name: 'donthaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `sign in`
  String get signIn {
    return Intl.message(
      'sign in',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `sign up`
  String get signup {
    return Intl.message(
      'sign up',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `Hello with our app`
  String get hellosigninfamily {
    return Intl.message(
      'Hello with our app',
      name: 'hellosigninfamily',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Your email and password`
  String get enterPassAndEmail {
    return Intl.message(
      'Please enter Your email and password',
      name: 'enterPassAndEmail',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get password {
    return Intl.message(
      'password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `forget Your Password`
  String get forgetYourPassword {
    return Intl.message(
      'forget Your Password',
      name: 'forgetYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter Your email`
  String get enterEmail {
    return Intl.message(
      'Please enter Your email',
      name: 'enterEmail',
      desc: '',
      args: [],
    );
  }

  /// `send`
  String get send {
    return Intl.message(
      'send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `please check your email to get the code`
  String get pleasecheckyouremailtogetthecode {
    return Intl.message(
      'please check your email to get the code',
      name: 'pleasecheckyouremailtogetthecode',
      desc: '',
      args: [],
    );
  }

  /// `your code number from email`
  String get codefromemail {
    return Intl.message(
      'your code number from email',
      name: 'codefromemail',
      desc: '',
      args: [],
    );
  }

  /// `rewrite passsword`
  String get rewritepasssword {
    return Intl.message(
      'rewrite passsword',
      name: 'rewritepasssword',
      desc: '',
      args: [],
    );
  }

  /// `Recreate your password`
  String get rewritepassswordtitle {
    return Intl.message(
      'Recreate your password',
      name: 'rewritepassswordtitle',
      desc: '',
      args: [],
    );
  }

  /// `Recovery`
  String get recoveryyourpassword {
    return Intl.message(
      'Recovery',
      name: 'recoveryyourpassword',
      desc: '',
      args: [],
    );
  }

  /// `full name`
  String get register_driver_name {
    return Intl.message(
      'full name',
      name: 'register_driver_name',
      desc: '',
      args: [],
    );
  }

  /// `city`
  String get city {
    return Intl.message(
      'city',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `National Identity Number`
  String get idnumber {
    return Intl.message(
      'National Identity Number',
      name: 'idnumber',
      desc: '',
      args: [],
    );
  }

  /// `personal Image`
  String get personalImage {
    return Intl.message(
      'personal Image',
      name: 'personalImage',
      desc: '',
      args: [],
    );
  }

  /// `shopping cart`
  String get shoppingcart {
    return Intl.message(
      'shopping cart',
      name: 'shoppingcart',
      desc: '',
      args: [],
    );
  }

  /// `cancel the request`
  String get cancelrequest {
    return Intl.message(
      'cancel the request',
      name: 'cancelrequest',
      desc: '',
      args: [],
    );
  }

  /// `Confirm to cancel the request ?`
  String get areyousureaboutcancelingtherequest {
    return Intl.message(
      'Confirm to cancel the request ?',
      name: 'areyousureaboutcancelingtherequest',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure about deleting the product ؟`
  String get areyousureaboutdeletingtheProduct {
    return Intl.message(
      'Are you sure about deleting the product ؟',
      name: 'areyousureaboutdeletingtheProduct',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure about deleting the offer ؟`
  String get areyousureaboutdeletingtheOffer {
    return Intl.message(
      'Are you sure about deleting the offer ؟',
      name: 'areyousureaboutdeletingtheOffer',
      desc: '',
      args: [],
    );
  }

  /// `cancel`
  String get cancel {
    return Intl.message(
      'cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `back`
  String get back {
    return Intl.message(
      'back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `confirm request`
  String get confirmrequest {
    return Intl.message(
      'confirm request',
      name: 'confirmrequest',
      desc: '',
      args: [],
    );
  }

  /// `confirm`
  String get confirm {
    return Intl.message(
      'confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `you will recieve a notification of the time needed of finish order`
  String get youwillrecieveanotificationofthetimeneededtofinishyourorder {
    return Intl.message(
      'you will recieve a notification of the time needed of finish order',
      name: 'youwillrecieveanotificationofthetimeneededtofinishyourorder',
      desc: '',
      args: [],
    );
  }

  /// `new order`
  String get neworder {
    return Intl.message(
      'new order',
      name: 'neworder',
      desc: '',
      args: [],
    );
  }

  /// `pay`
  String get pay {
    return Intl.message(
      'pay',
      name: 'pay',
      desc: '',
      args: [],
    );
  }

  /// `verify from account`
  String get verifyfromaccount {
    return Intl.message(
      'verify from account',
      name: 'verifyfromaccount',
      desc: '',
      args: [],
    );
  }

  /// `By verifying your account, you will be able to request and obtain application privileges`
  String get explainverifyfromaccount {
    return Intl.message(
      'By verifying your account, you will be able to request and obtain application privileges',
      name: 'explainverifyfromaccount',
      desc: '',
      args: [],
    );
  }

  /// `next`
  String get next {
    return Intl.message(
      'next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `sign up with gmail`
  String get signupwithgmail {
    return Intl.message(
      'sign up with gmail',
      name: 'signupwithgmail',
      desc: '',
      args: [],
    );
  }

  /// `sign up with apple`
  String get signupwithapple {
    return Intl.message(
      'sign up with apple',
      name: 'signupwithapple',
      desc: '',
      args: [],
    );
  }

  /// `sale over`
  String get saleover {
    return Intl.message(
      'sale over',
      name: 'saleover',
      desc: '',
      args: [],
    );
  }

  /// `additional notes`
  String get additionalnotes {
    return Intl.message(
      'additional notes',
      name: 'additionalnotes',
      desc: '',
      args: [],
    );
  }

  /// `code number`
  String get codenumber {
    return Intl.message(
      'code number',
      name: 'codenumber',
      desc: '',
      args: [],
    );
  }

  /// `please enter the code`
  String get pleaseenterthesendcode {
    return Intl.message(
      'please enter the code',
      name: 'pleaseenterthesendcode',
      desc: '',
      args: [],
    );
  }

  /// `products`
  String get products {
    return Intl.message(
      'products',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `families`
  String get producerfamilies {
    return Intl.message(
      'families',
      name: 'producerfamilies',
      desc: '',
      args: [],
    );
  }

  /// `sales`
  String get sales {
    return Intl.message(
      'sales',
      name: 'sales',
      desc: '',
      args: [],
    );
  }

  /// `all`
  String get all {
    return Intl.message(
      'all',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `search`
  String get search {
    return Intl.message(
      'search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `location`
  String get location {
    return Intl.message(
      'location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `reviews`
  String get reviews {
    return Intl.message(
      'reviews',
      name: 'reviews',
      desc: '',
      args: [],
    );
  }

  /// `policies`
  String get policies {
    return Intl.message(
      'policies',
      name: 'policies',
      desc: '',
      args: [],
    );
  }

  /// `waiting`
  String get waiting {
    return Intl.message(
      'waiting',
      name: 'waiting',
      desc: '',
      args: [],
    );
  }

  /// `current`
  String get currentt {
    return Intl.message(
      'current',
      name: 'currentt',
      desc: '',
      args: [],
    );
  }

  /// `end`
  String get end {
    return Intl.message(
      'end',
      name: 'end',
      desc: '',
      args: [],
    );
  }

  /// `continue`
  String get chooseyourdriver {
    return Intl.message(
      'continue',
      name: 'chooseyourdriver',
      desc: '',
      args: [],
    );
  }

  /// `accept deal`
  String get acceptdeal {
    return Intl.message(
      'accept deal',
      name: 'acceptdeal',
      desc: '',
      args: [],
    );
  }

  /// `refresh`
  String get refresh {
    return Intl.message(
      'refresh',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }

  /// `details`
  String get details {
    return Intl.message(
      'details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `followorder`
  String get followorder {
    return Intl.message(
      'followorder',
      name: 'followorder',
      desc: '',
      args: [],
    );
  }

  /// `rate order`
  String get rateorder {
    return Intl.message(
      'rate order',
      name: 'rateorder',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get statistics {
    return Intl.message(
      'Statistics',
      name: 'statistics',
      desc: '',
      args: [],
    );
  }

  /// `done`
  String get completed {
    return Intl.message(
      'done',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `max`
  String get requested {
    return Intl.message(
      'max',
      name: 'requested',
      desc: '',
      args: [],
    );
  }

  /// `Bonus`
  String get bonus {
    return Intl.message(
      'Bonus',
      name: 'bonus',
      desc: '',
      args: [],
    );
  }

  /// `Daily`
  String get daily {
    return Intl.message(
      'Daily',
      name: 'daily',
      desc: '',
      args: [],
    );
  }

  /// `Weekly`
  String get weekly {
    return Intl.message(
      'Weekly',
      name: 'weekly',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get monthly {
    return Intl.message(
      'Monthly',
      name: 'monthly',
      desc: '',
      args: [],
    );
  }

  /// `Complete Orders`
  String get completeOrders {
    return Intl.message(
      'Complete Orders',
      name: 'completeOrders',
      desc: '',
      args: [],
    );
  }

  /// `Bonus Orders`
  String get bonusOrders {
    return Intl.message(
      'Bonus Orders',
      name: 'bonusOrders',
      desc: '',
      args: [],
    );
  }

  /// `Pending Orders`
  String get pendingOrders {
    return Intl.message(
      'Pending Orders',
      name: 'pendingOrders',
      desc: '',
      args: [],
    );
  }

  /// `Canceled Orders`
  String get canceledOrders {
    return Intl.message(
      'Canceled Orders',
      name: 'canceledOrders',
      desc: '',
      args: [],
    );
  }

  /// `Sold Products`
  String get soldProducts {
    return Intl.message(
      'Sold Products',
      name: 'soldProducts',
      desc: '',
      args: [],
    );
  }

  /// `Total Products`
  String get totalProducts {
    return Intl.message(
      'Total Products',
      name: 'totalProducts',
      desc: '',
      args: [],
    );
  }

  /// `Total Amount`
  String get totalAmount {
    return Intl.message(
      'Total Amount',
      name: 'totalAmount',
      desc: '',
      args: [],
    );
  }

  /// `Commission`
  String get applicationCommission {
    return Intl.message(
      'Commission',
      name: 'applicationCommission',
      desc: '',
      args: [],
    );
  }

  /// `Profits`
  String get profits {
    return Intl.message(
      'Profits',
      name: 'profits',
      desc: '',
      args: [],
    );
  }

  /// `Family Information`
  String get familyInfo {
    return Intl.message(
      'Family Information',
      name: 'familyInfo',
      desc: '',
      args: [],
    );
  }

  /// `Arabic Description`
  String get arabicDescription {
    return Intl.message(
      'Arabic Description',
      name: 'arabicDescription',
      desc: '',
      args: [],
    );
  }

  /// `English Description`
  String get englishDescription {
    return Intl.message(
      'English Description',
      name: 'englishDescription',
      desc: '',
      args: [],
    );
  }

  /// `English Policies`
  String get englishPolicies {
    return Intl.message(
      'English Policies',
      name: 'englishPolicies',
      desc: '',
      args: [],
    );
  }

  /// `Arabic Policies`
  String get arabicPolicies {
    return Intl.message(
      'Arabic Policies',
      name: 'arabicPolicies',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get confirmNewPassword {
    return Intl.message(
      'Confirm New Password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Edit The Password`
  String get editPassword {
    return Intl.message(
      'Edit The Password',
      name: 'editPassword',
      desc: '',
      args: [],
    );
  }

  /// `available`
  String get available {
    return Intl.message(
      'available',
      name: 'available',
      desc: '',
      args: [],
    );
  }

  /// `unavailable`
  String get unavailable {
    return Intl.message(
      'unavailable',
      name: 'unavailable',
      desc: '',
      args: [],
    );
  }

  /// `Add policies`
  String get addPolicies {
    return Intl.message(
      'Add policies',
      name: 'addPolicies',
      desc: '',
      args: [],
    );
  }

  /// `Administration`
  String get administration {
    return Intl.message(
      'Administration',
      name: 'administration',
      desc: '',
      args: [],
    );
  }

  /// `Your message`
  String get yourMessage {
    return Intl.message(
      'Your message',
      name: 'yourMessage',
      desc: '',
      args: [],
    );
  }

  /// `store`
  String get store {
    return Intl.message(
      'store',
      name: 'store',
      desc: '',
      args: [],
    );
  }

  /// `offers/products`
  String get productsOffers {
    return Intl.message(
      'offers/products',
      name: 'productsOffers',
      desc: '',
      args: [],
    );
  }

  /// `add`
  String get addProductsOffers {
    return Intl.message(
      'add',
      name: 'addProductsOffers',
      desc: '',
      args: [],
    );
  }

  /// `categories`
  String get categories {
    return Intl.message(
      'categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Family Categories`
  String get myCategories {
    return Intl.message(
      'Family Categories',
      name: 'myCategories',
      desc: '',
      args: [],
    );
  }

  /// `Arabic Category`
  String get arabicCategory {
    return Intl.message(
      'Arabic Category',
      name: 'arabicCategory',
      desc: '',
      args: [],
    );
  }

  /// `English Category`
  String get englishCategory {
    return Intl.message(
      'English Category',
      name: 'englishCategory',
      desc: '',
      args: [],
    );
  }

  /// `delete`
  String get delete {
    return Intl.message(
      'delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `edit`
  String get edit {
    return Intl.message(
      'edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `add it as Offer`
  String get addOffer {
    return Intl.message(
      'add it as Offer',
      name: 'addOffer',
      desc: '',
      args: [],
    );
  }

  /// `Delete the product`
  String get deleteProduct {
    return Intl.message(
      'Delete the product',
      name: 'deleteProduct',
      desc: '',
      args: [],
    );
  }

  /// `cancel the offer`
  String get deleteOffer {
    return Intl.message(
      'cancel the offer',
      name: 'deleteOffer',
      desc: '',
      args: [],
    );
  }

  /// `yes`
  String get yes {
    return Intl.message(
      'yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `no`
  String get no {
    return Intl.message(
      'no',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `discount`
  String get discount {
    return Intl.message(
      'discount',
      name: 'discount',
      desc: '',
      args: [],
    );
  }

  /// `details of offer`
  String get detailsOfOffer {
    return Intl.message(
      'details of offer',
      name: 'detailsOfOffer',
      desc: '',
      args: [],
    );
  }

  /// `Number of hours`
  String get numberOfHours {
    return Intl.message(
      'Number of hours',
      name: 'numberOfHours',
      desc: '',
      args: [],
    );
  }

  /// `Number of minutes`
  String get numberOfMinutes {
    return Intl.message(
      'Number of minutes',
      name: 'numberOfMinutes',
      desc: '',
      args: [],
    );
  }

  /// `The price after`
  String get thePriceAfter {
    return Intl.message(
      'The price after',
      name: 'thePriceAfter',
      desc: '',
      args: [],
    );
  }

  /// `Product Images`
  String get productImages {
    return Intl.message(
      'Product Images',
      name: 'productImages',
      desc: '',
      args: [],
    );
  }

  /// `Processing time`
  String get processingTime {
    return Intl.message(
      'Processing time',
      name: 'processingTime',
      desc: '',
      args: [],
    );
  }

  /// `from`
  String get from {
    return Intl.message(
      'from',
      name: 'from',
      desc: '',
      args: [],
    );
  }

  /// `to`
  String get to {
    return Intl.message(
      'to',
      name: 'to',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Unit`
  String get unitPrice {
    return Intl.message(
      'Unit',
      name: 'unitPrice',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get totalPrice {
    return Intl.message(
      'Total',
      name: 'totalPrice',
      desc: '',
      args: [],
    );
  }

  /// `Total cost`
  String get totalCost {
    return Intl.message(
      'Total cost',
      name: 'totalCost',
      desc: '',
      args: [],
    );
  }

  /// `order cost`
  String get orderCost {
    return Intl.message(
      'order cost',
      name: 'orderCost',
      desc: '',
      args: [],
    );
  }

  /// `Prepared`
  String get prepared {
    return Intl.message(
      'Prepared',
      name: 'prepared',
      desc: '',
      args: [],
    );
  }

  /// `Refuse`
  String get refuse {
    return Intl.message(
      'Refuse',
      name: 'refuse',
      desc: '',
      args: [],
    );
  }

  /// `User notes`
  String get userNotes {
    return Intl.message(
      'User notes',
      name: 'userNotes',
      desc: '',
      args: [],
    );
  }

  /// `Family notes`
  String get familyNotes {
    return Intl.message(
      'Family notes',
      name: 'familyNotes',
      desc: '',
      args: [],
    );
  }

  /// `review`
  String get review {
    return Intl.message(
      'review',
      name: 'review',
      desc: '',
      args: [],
    );
  }

  /// `Request the rate`
  String get requestTheRate {
    return Intl.message(
      'Request the rate',
      name: 'requestTheRate',
      desc: '',
      args: [],
    );
  }

  /// `chat with driver`
  String get chatWithDriver {
    return Intl.message(
      'chat with driver',
      name: 'chatWithDriver',
      desc: '',
      args: [],
    );
  }

  /// `chat with family`
  String get chatWithFamily {
    return Intl.message(
      'chat with family',
      name: 'chatWithFamily',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get reporting {
    return Intl.message(
      'Report',
      name: 'reporting',
      desc: '',
      args: [],
    );
  }

  /// `complaint about`
  String get complaintAbout {
    return Intl.message(
      'complaint about',
      name: 'complaintAbout',
      desc: '',
      args: [],
    );
  }

  /// `customer`
  String get user {
    return Intl.message(
      'customer',
      name: 'user',
      desc: '',
      args: [],
    );
  }

  /// `driver`
  String get driver {
    return Intl.message(
      'driver',
      name: 'driver',
      desc: '',
      args: [],
    );
  }

  /// `family`
  String get family {
    return Intl.message(
      'family',
      name: 'family',
      desc: '',
      args: [],
    );
  }

  /// `public`
  String get public {
    return Intl.message(
      'public',
      name: 'public',
      desc: '',
      args: [],
    );
  }

  /// `order number`
  String get orderNumber {
    return Intl.message(
      'order number',
      name: 'orderNumber',
      desc: '',
      args: [],
    );
  }

  /// `complaint content`
  String get complaintContent {
    return Intl.message(
      'complaint content',
      name: 'complaintContent',
      desc: '',
      args: [],
    );
  }

  /// `waiting`
  String get beforeNewOrdersDriver {
    return Intl.message(
      'waiting',
      name: 'beforeNewOrdersDriver',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `delivery time`
  String get deliveryTi {
    return Intl.message(
      'delivery time',
      name: 'deliveryTi',
      desc: '',
      args: [],
    );
  }

  /// `delivery cost`
  String get deliveryCost {
    return Intl.message(
      'delivery cost',
      name: 'deliveryCost',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueUp {
    return Intl.message(
      'Continue',
      name: 'continueUp',
      desc: '',
      args: [],
    );
  }

  /// `Rate me`
  String get rateMe {
    return Intl.message(
      'Rate me',
      name: 'rateMe',
      desc: '',
      args: [],
    );
  }

  /// `price`
  String get price {
    return Intl.message(
      'price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `put your location`
  String get searchMap {
    return Intl.message(
      'put your location',
      name: 'searchMap',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get changeLocation {
    return Intl.message(
      'Location',
      name: 'changeLocation',
      desc: '',
      args: [],
    );
  }

  /// `comment`
  String get comment {
    return Intl.message(
      'comment',
      name: 'comment',
      desc: '',
      args: [],
    );
  }

  /// `Our representative has received your request`
  String get ourRepresentativeHasReceivedYourRequest {
    return Intl.message(
      'Our representative has received your request',
      name: 'ourRepresentativeHasReceivedYourRequest',
      desc: '',
      args: [],
    );
  }

  /// `done`
  String get done {
    return Intl.message(
      'done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Verify phone`
  String get verifyPhone {
    return Intl.message(
      'Verify phone',
      name: 'verifyPhone',
      desc: '',
      args: [],
    );
  }

  /// `The code is`
  String get theCodeIs {
    return Intl.message(
      'The code is',
      name: 'theCodeIs',
      desc: '',
      args: [],
    );
  }

  /// `Didn't recieve code?`
  String get moCode {
    return Intl.message(
      'Didn\'t recieve code?',
      name: 'moCode',
      desc: '',
      args: [],
    );
  }

  /// `Request again`
  String get requestAgain {
    return Intl.message(
      'Request again',
      name: 'requestAgain',
      desc: '',
      args: [],
    );
  }

  /// `chat with customer`
  String get chatWithCustomer {
    return Intl.message(
      'chat with customer',
      name: 'chatWithCustomer',
      desc: '',
      args: [],
    );
  }

  /// `chat`
  String get chat {
    return Intl.message(
      'chat',
      name: 'chat',
      desc: '',
      args: [],
    );
  }

  /// `add your location`
  String get addYourLocation {
    return Intl.message(
      'add your location',
      name: 'addYourLocation',
      desc: '',
      args: [],
    );
  }

  /// `log in`
  String get logIn {
    return Intl.message(
      'log in',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `count`
  String get count {
    return Intl.message(
      'count',
      name: 'count',
      desc: '',
      args: [],
    );
  }

  /// `minute`
  String get m {
    return Intl.message(
      'minute',
      name: 'm',
      desc: '',
      args: [],
    );
  }

  /// `hour`
  String get h {
    return Intl.message(
      'hour',
      name: 'h',
      desc: '',
      args: [],
    );
  }

  /// `day`
  String get d {
    return Intl.message(
      'day',
      name: 'd',
      desc: '',
      args: [],
    );
  }

  /// `The minimum order`
  String get theminimumorder {
    return Intl.message(
      'The minimum order',
      name: 'theminimumorder',
      desc: '',
      args: [],
    );
  }

  /// `reyal`
  String get reyal {
    return Intl.message(
      'reyal',
      name: 'reyal',
      desc: '',
      args: [],
    );
  }

  /// `product name`
  String get productName {
    return Intl.message(
      'product name',
      name: 'productName',
      desc: '',
      args: [],
    );
  }

  /// `offer duration`
  String get offerDuration {
    return Intl.message(
      'offer duration',
      name: 'offerDuration',
      desc: '',
      args: [],
    );
  }

  /// `coupon code`
  String get coupon {
    return Intl.message(
      'coupon code',
      name: 'coupon',
      desc: '',
      args: [],
    );
  }

  /// `final cost`
  String get finalCost {
    return Intl.message(
      'final cost',
      name: 'finalCost',
      desc: '',
      args: [],
    );
  }

  /// `check`
  String get check {
    return Intl.message(
      'check',
      name: 'check',
      desc: '',
      args: [],
    );
  }

  /// `credit`
  String get credit {
    return Intl.message(
      'credit',
      name: 'credit',
      desc: '',
      args: [],
    );
  }

  /// `user name`
  String get nameUser {
    return Intl.message(
      'user name',
      name: 'nameUser',
      desc: '',
      args: [],
    );
  }

  /// `family name`
  String get nameFamily {
    return Intl.message(
      'family name',
      name: 'nameFamily',
      desc: '',
      args: [],
    );
  }

  /// `driver name`
  String get nameDriver {
    return Intl.message(
      'driver name',
      name: 'nameDriver',
      desc: '',
      args: [],
    );
  }

  /// `hour`
  String get hour {
    return Intl.message(
      'hour',
      name: 'hour',
      desc: '',
      args: [],
    );
  }

  /// `day`
  String get day {
    return Intl.message(
      'day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `minute`
  String get minute {
    return Intl.message(
      'minute',
      name: 'minute',
      desc: '',
      args: [],
    );
  }

  /// `There is no orders`
  String get thereIsnoOrders {
    return Intl.message(
      'There is no orders',
      name: 'thereIsnoOrders',
      desc: '',
      args: [],
    );
  }

  /// `There is no products`
  String get thereIsnoProducts {
    return Intl.message(
      'There is no products',
      name: 'thereIsnoProducts',
      desc: '',
      args: [],
    );
  }

  /// `There is no categories`
  String get thereIsnoCategories {
    return Intl.message(
      'There is no categories',
      name: 'thereIsnoCategories',
      desc: '',
      args: [],
    );
  }

  /// `There is no notifications`
  String get thereIsnoNotifications {
    return Intl.message(
      'There is no notifications',
      name: 'thereIsnoNotifications',
      desc: '',
      args: [],
    );
  }

  /// `There is no sales`
  String get thereIsnoSales {
    return Intl.message(
      'There is no sales',
      name: 'thereIsnoSales',
      desc: '',
      args: [],
    );
  }

  /// `There is no messages`
  String get thereIsnoMessages {
    return Intl.message(
      'There is no messages',
      name: 'thereIsnoMessages',
      desc: '',
      args: [],
    );
  }

  /// `There is no drivers until now,press refresh`
  String get thereIsnoDriversUntilNow {
    return Intl.message(
      'There is no drivers until now,press refresh',
      name: 'thereIsnoDriversUntilNow',
      desc: '',
      args: [],
    );
  }

  /// `Please choose one category for your product area`
  String get pleaseChooseOneCategoryForYourProductArea {
    return Intl.message(
      'Please choose one category for your product area',
      name: 'pleaseChooseOneCategoryForYourProductArea',
      desc: '',
      args: [],
    );
  }

  /// `add`
  String get add {
    return Intl.message(
      'add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `shopNow`
  String get shopNow {
    return Intl.message(
      'shopNow',
      name: 'shopNow',
      desc: '',
      args: [],
    );
  }

  /// `no parchases in the cart`
  String get noParchasesInTheCart {
    return Intl.message(
      'no parchases in the cart',
      name: 'noParchasesInTheCart',
      desc: '',
      args: [],
    );
  }

  /// `archieve`
  String get archieve {
    return Intl.message(
      'archieve',
      name: 'archieve',
      desc: '',
      args: [],
    );
  }

  /// `The results from search are`
  String get theResultsFromSearchAre {
    return Intl.message(
      'The results from search are',
      name: 'theResultsFromSearchAre',
      desc: '',
      args: [],
    );
  }

  /// `Data is being modified`
  String get dataIsBeingModified {
    return Intl.message(
      'Data is being modified',
      name: 'dataIsBeingModified',
      desc: '',
      args: [],
    );
  }

  /// `please enter correct data`
  String get pleaseEnterCorrectData {
    return Intl.message(
      'please enter correct data',
      name: 'pleaseEnterCorrectData',
      desc: '',
      args: [],
    );
  }

  /// `optional`
  String get optional {
    return Intl.message(
      'optional',
      name: 'optional',
      desc: '',
      args: [],
    );
  }

  /// `please enter one image`
  String get pleaseEnterImage {
    return Intl.message(
      'please enter one image',
      name: 'pleaseEnterImage',
      desc: '',
      args: [],
    );
  }

  /// `please accept our terms and condions`
  String get pleaseAcceptOurTermsAndCondions {
    return Intl.message(
      'please accept our terms and condions',
      name: 'pleaseAcceptOurTermsAndCondions',
      desc: '',
      args: [],
    );
  }

  /// `The form of email is not correct`
  String get theFormOfEmailIsNotCorrect {
    return Intl.message(
      'The form of email is not correct',
      name: 'theFormOfEmailIsNotCorrect',
      desc: '',
      args: [],
    );
  }

  /// `The field is required`
  String get theFieldIsRequired {
    return Intl.message(
      'The field is required',
      name: 'theFieldIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `The number of fields is not correct`
  String get theNumberOfFieldsIsNotMoreThan10 {
    return Intl.message(
      'The number of fields is not correct',
      name: 'theNumberOfFieldsIsNotMoreThan10',
      desc: '',
      args: [],
    );
  }

  /// `The number of fields is not correct`
  String get theNumberOfFieldsIsNotLessThan10 {
    return Intl.message(
      'The number of fields is not correct',
      name: 'theNumberOfFieldsIsNotLessThan10',
      desc: '',
      args: [],
    );
  }

  /// `Please upload a picture of yourself`
  String get pleaseIploadAPictureOfYourself {
    return Intl.message(
      'Please upload a picture of yourself',
      name: 'pleaseIploadAPictureOfYourself',
      desc: '',
      args: [],
    );
  }

  /// `The family is not available now`
  String get theFamilyIsNotAvailableNow {
    return Intl.message(
      'The family is not available now',
      name: 'theFamilyIsNotAvailableNow',
      desc: '',
      args: [],
    );
  }

  /// `sendTheVerificationCodeAgain`
  String get sendTheVerificationCodeAgain {
    return Intl.message(
      'sendTheVerificationCodeAgain',
      name: 'sendTheVerificationCodeAgain',
      desc: '',
      args: [],
    );
  }

  /// `product category`
  String get productCategory {
    return Intl.message(
      'product category',
      name: 'productCategory',
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

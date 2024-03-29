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

  /// `Age`
  String get age {
    return Intl.message(
      'Age',
      name: 'age',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
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

  /// `This area cannot be viewed without internet connection`
  String get cannotBeViewedWithoutInternet {
    return Intl.message(
      'This area cannot be viewed without internet connection',
      name: 'cannotBeViewedWithoutInternet',
      desc: '',
      args: [],
    );
  }

  /// `Casilla de verificació d'informació`
  String get checkboxInfo {
    return Intl.message(
      'Casilla de verificació d\'informació',
      name: 'checkboxInfo',
      desc: '',
      args: [],
    );
  }

  /// `Legal checkbox`
  String get checkboxLegal {
    return Intl.message(
      'Legal checkbox',
      name: 'checkboxLegal',
      desc: '',
      args: [],
    );
  }

  /// `Privacy checkbox`
  String get checkboxPrivacy {
    return Intl.message(
      'Privacy checkbox',
      name: 'checkboxPrivacy',
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

  /// `Confirmation email`
  String get confirmationEmail {
    return Intl.message(
      'Confirmation email',
      name: 'confirmationEmail',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation Password`
  String get confirmationPassword {
    return Intl.message(
      'Confirmation Password',
      name: 'confirmationPassword',
      desc: '',
      args: [],
    );
  }

  /// `Contact`
  String get contact {
    return Intl.message(
      'Contact',
      name: 'contact',
      desc: '',
      args: [],
    );
  }

  /// `Kentish plover`
  String get corriolCamanegre {
    return Intl.message(
      'Kentish plover',
      name: 'corriolCamanegre',
      desc: '',
      args: [],
    );
  }

  /// `Little ringed plover`
  String get corriolPetit {
    return Intl.message(
      'Little ringed plover',
      name: 'corriolPetit',
      desc: '',
      args: [],
    );
  }

  /// `Delete my account`
  String get deleteMyAccount {
    return Intl.message(
      'Delete my account',
      name: 'deleteMyAccount',
      desc: '',
      args: [],
    );
  }

  /// `Deleting the account will delete all personal information and cannot be recovered (a new account must be created). Information regarding the observations created will be maintained.`
  String get deleteMyAccountContent {
    return Intl.message(
      'Deleting the account will delete all personal information and cannot be recovered (a new account must be created). Information regarding the observations created will be maintained.',
      name: 'deleteMyAccountContent',
      desc: '',
      args: [],
    );
  }

  /// `Directory doesn't exist`
  String get directoryDoesntExist {
    return Intl.message(
      'Directory doesn\'t exist',
      name: 'directoryDoesntExist',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `The email address is already in use by another account.`
  String get emailAlreadyInUse {
    return Intl.message(
      'The email address is already in use by another account.',
      name: 'emailAlreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `Email sent`
  String get emailSent {
    return Intl.message(
      'Email sent',
      name: 'emailSent',
      desc: '',
      args: [],
    );
  }

  /// `If you want to participate actively in the conservation of the Plover or have any questions or proposals, please contact us: `
  String get emailText {
    return Intl.message(
      'If you want to participate actively in the conservation of the Plover or have any questions or proposals, please contact us: ',
      name: 'emailText',
      desc: '',
      args: [],
    );
  }

  /// `Emails are different`
  String get errorDifferentEmails {
    return Intl.message(
      'Emails are different',
      name: 'errorDifferentEmails',
      desc: '',
      args: [],
    );
  }

  /// `Passwords are different`
  String get errorDifferentPasswords {
    return Intl.message(
      'Passwords are different',
      name: 'errorDifferentPasswords',
      desc: '',
      args: [],
    );
  }

  /// `Cannot perform this action because there are empty fields`
  String get errorEmptyFields {
    return Intl.message(
      'Cannot perform this action because there are empty fields',
      name: 'errorEmptyFields',
      desc: '',
      args: [],
    );
  }

  /// `The requested information could not be obtained`
  String get errorGetInfo {
    return Intl.message(
      'The requested information could not be obtained',
      name: 'errorGetInfo',
      desc: '',
      args: [],
    );
  }

  /// `Could not enable location permission. Change it manually in the device settings.`
  String get errorGps {
    return Intl.message(
      'Could not enable location permission. Change it manually in the device settings.',
      name: 'errorGps',
      desc: '',
      args: [],
    );
  }

  /// `Could not launch:`
  String get errorLaunchUrl {
    return Intl.message(
      'Could not launch:',
      name: 'errorLaunchUrl',
      desc: '',
      args: [],
    );
  }

  /// `Wrong email or password`
  String get errorPassword {
    return Intl.message(
      'Wrong email or password',
      name: 'errorPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please sign in again before trying this request again`
  String get errorReDoLogin {
    return Intl.message(
      'Please sign in again before trying this request again',
      name: 'errorReDoLogin',
      desc: '',
      args: [],
    );
  }

  /// `Failed to save the given information`
  String get errorSaveInfo {
    return Intl.message(
      'Failed to save the given information',
      name: 'errorSaveInfo',
      desc: '',
      args: [],
    );
  }

  /// `Access to this account has been temporarily disabled due to many failed login attempts. You can immediately restore it by resetting your password or you can try again later.`
  String get errorToManyRequestsFirebase {
    return Intl.message(
      'Access to this account has been temporarily disabled due to many failed login attempts. You can immediately restore it by resetting your password or you can try again later.',
      name: 'errorToManyRequestsFirebase',
      desc: '',
      args: [],
    );
  }

  /// `File saved`
  String get fileSave {
    return Intl.message(
      'File saved',
      name: 'fileSave',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Go to device app settings`
  String get goToDeviceSettings {
    return Intl.message(
      'Go to device app settings',
      name: 'goToDeviceSettings',
      desc: '',
      args: [],
    );
  }

  /// `Handyman`
  String get handyman {
    return Intl.message(
      'Handyman',
      name: 'handyman',
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

  /// `Internet connection`
  String get inernetConnection {
    return Intl.message(
      'Internet connection',
      name: 'inernetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Informative clause, form, registration, activities`
  String get infoClause {
    return Intl.message(
      'Informative clause, form, registration, activities',
      name: 'infoClause',
      desc: '',
      args: [],
    );
  }

  /// `The email address is incorrectly formatted. Check that there are no blank spaces.`
  String get invalidEmail {
    return Intl.message(
      'The email address is incorrectly formatted. Check that there are no blank spaces.',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get lang {
    return Intl.message(
      'Language',
      name: 'lang',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get language {
    return Intl.message(
      'English',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Read the PDFs and check the boxes to accept the documents`
  String get legalFields {
    return Intl.message(
      'Read the PDFs and check the boxes to accept the documents',
      name: 'legalFields',
      desc: '',
      args: [],
    );
  }

  /// `Legal warning`
  String get legalWarning {
    return Intl.message(
      'Legal warning',
      name: 'legalWarning',
      desc: '',
      args: [],
    );
  }

  /// `Cats`
  String get legendCats {
    return Intl.message(
      'Cats',
      name: 'legendCats',
      desc: '',
      args: [],
    );
  }

  /// `Chicks`
  String get legendChickens {
    return Intl.message(
      'Chicks',
      name: 'legendChickens',
      desc: '',
      args: [],
    );
  }

  /// `Dogs`
  String get legendDogs {
    return Intl.message(
      'Dogs',
      name: 'legendDogs',
      desc: '',
      args: [],
    );
  }

  /// `Females`
  String get legendFemales {
    return Intl.message(
      'Females',
      name: 'legendFemales',
      desc: '',
      args: [],
    );
  }

  /// `Males`
  String get legendMales {
    return Intl.message(
      'Males',
      name: 'legendMales',
      desc: '',
      args: [],
    );
  }

  /// `Undetermined`
  String get legendUndetermined {
    return Intl.message(
      'Undetermined',
      name: 'legendUndetermined',
      desc: '',
      args: [],
    );
  }

  /// `Meet the Kenthish Plover`
  String get meetKentishPlover {
    return Intl.message(
      'Meet the Kenthish Plover',
      name: 'meetKentishPlover',
      desc: '',
      args: [],
    );
  }

  /// `If you don't see the reports it's because you haven't created one, try creating one \n (if the problem persists, get in touch)`
  String get messageReportsDontShow {
    return Intl.message(
      'If you don\'t see the reports it\'s because you haven\'t created one, try creating one \n (if the problem persists, get in touch)',
      name: 'messageReportsDontShow',
      desc: '',
      args: [],
    );
  }

  /// `Mobile data`
  String get mobileData {
    return Intl.message(
      'Mobile data',
      name: 'mobileData',
      desc: '',
      args: [],
    );
  }

  /// `My records`
  String get myRecords {
    return Intl.message(
      'My records',
      name: 'myRecords',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get noInternetConnection {
    return Intl.message(
      'No internet connection',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy policy',
      name: 'privacyPolicy',
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

  /// `Record an observation`
  String get recordObservation {
    return Intl.message(
      'Record an observation',
      name: 'recordObservation',
      desc: '',
      args: [],
    );
  }

  /// `Tap to refresh`
  String get refresh {
    return Intl.message(
      'Tap to refresh',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Saved information`
  String get saveInformation {
    return Intl.message(
      'Saved information',
      name: 'saveInformation',
      desc: '',
      args: [],
    );
  }

  /// `Cats`
  String get screen1_3_Button_Cats {
    return Intl.message(
      'Cats',
      name: 'screen1_3_Button_Cats',
      desc: '',
      args: [],
    );
  }

  /// `Chickens`
  String get screen1_3_Button_Chickens {
    return Intl.message(
      'Chickens',
      name: 'screen1_3_Button_Chickens',
      desc: '',
      args: [],
    );
  }

  /// `Dogs`
  String get screen1_3_Button_Dogs {
    return Intl.message(
      'Dogs',
      name: 'screen1_3_Button_Dogs',
      desc: '',
      args: [],
    );
  }

  /// `Females`
  String get screen1_3_Button_Females {
    return Intl.message(
      'Females',
      name: 'screen1_3_Button_Females',
      desc: '',
      args: [],
    );
  }

  /// `Males`
  String get screen1_3_Button_Males {
    return Intl.message(
      'Males',
      name: 'screen1_3_Button_Males',
      desc: '',
      args: [],
    );
  }

  /// `Select species`
  String get screen1_3_Button_Select_Specie {
    return Intl.message(
      'Select species',
      name: 'screen1_3_Button_Select_Specie',
      desc: '',
      args: [],
    );
  }

  /// `Kentish Plover`
  String get screen1_3_Button_Select_Specie_Camanegre {
    return Intl.message(
      'Kentish Plover',
      name: 'screen1_3_Button_Select_Specie_Camanegre',
      desc: '',
      args: [],
    );
  }

  /// `Little ringed plover`
  String get screen1_3_Button_Select_Specie_Petit {
    return Intl.message(
      'Little ringed plover',
      name: 'screen1_3_Button_Select_Specie_Petit',
      desc: '',
      args: [],
    );
  }

  /// `Undetermined`
  String get screen1_3_Button_Undetermined {
    return Intl.message(
      'Undetermined',
      name: 'screen1_3_Button_Undetermined',
      desc: '',
      args: [],
    );
  }

  /// `Its reproduction period coincides with the time of year when the beaches are most frequented, from March to August.`
  String get screen_1_1_Foto_1_1_1_after {
    return Intl.message(
      'Its reproduction period coincides with the time of year when the beaches are most frequented, from March to August.',
      name: 'screen_1_1_Foto_1_1_1_after',
      desc: '',
      args: [],
    );
  }

  /// `The Kentish Plover is a small bird that lays its eggs in the sand on the beach`
  String get screen_1_1_Foto_1_1_1_before {
    return Intl.message(
      'The Kentish Plover is a small bird that lays its eggs in the sand on the beach',
      name: 'screen_1_1_Foto_1_1_1_before',
      desc: '',
      args: [],
    );
  }

  /// `The female lays 3 eggs in the sand that will be incubated by both the male and the female for approximately 25 days.`
  String get screen_1_1_Foto_1_1_2_after {
    return Intl.message(
      'The female lays 3 eggs in the sand that will be incubated by both the male and the female for approximately 25 days.',
      name: 'screen_1_1_Foto_1_1_2_after',
      desc: '',
      args: [],
    );
  }

  /// `Each female may lay more than one clutch of eggs during the breeding season.`
  String get screen_1_1_Foto_1_1_2_before {
    return Intl.message(
      'Each female may lay more than one clutch of eggs during the breeding season.',
      name: 'screen_1_1_Foto_1_1_2_before',
      desc: '',
      args: [],
    );
  }

  /// `They are easy prey for predators, but they grow quickly.`
  String get screen_1_1_Foto_1_1_3_after {
    return Intl.message(
      'They are easy prey for predators, but they grow quickly.',
      name: 'screen_1_1_Foto_1_1_3_after',
      desc: '',
      args: [],
    );
  }

  /// `The hatchlings are nidifugous. This means that they leave the nest when they are born, since they are capable of walking and feeding themselves.`
  String get screen_1_1_Foto_1_1_3_before {
    return Intl.message(
      'The hatchlings are nidifugous. This means that they leave the nest when they are born, since they are capable of walking and feeding themselves.',
      name: 'screen_1_1_Foto_1_1_3_before',
      desc: '',
      args: [],
    );
  }

  /// `It is a generally migratory specie that comes to our beaches to reproduce. If we take good care of it every season it will visit us again.`
  String get screen_1_1_Foto_1_1_4_after {
    return Intl.message(
      'It is a generally migratory specie that comes to our beaches to reproduce. If we take good care of it every season it will visit us again.',
      name: 'screen_1_1_Foto_1_1_4_after',
      desc: '',
      args: [],
    );
  }

  /// `When they reach 30 days of life they are able to fly from one beach to another.`
  String get screen_1_1_Foto_1_1_4_before {
    return Intl.message(
      'When they reach 30 days of life they are able to fly from one beach to another.',
      name: 'screen_1_1_Foto_1_1_4_before',
      desc: '',
      args: [],
    );
  }

  /// `And also because of the black necklace that it wears around the neck and of the spots on its eyes and forehead.`
  String get screen_1_1_Foto_1_1_5_after {
    return Intl.message(
      'And also because of the black necklace that it wears around the neck and of the spots on its eyes and forehead.',
      name: 'screen_1_1_Foto_1_1_5_after',
      desc: '',
      args: [],
    );
  }

  /// `We can distinguish the male from the female by its orange coloration on the head during the breeding season.`
  String get screen_1_1_Foto_1_1_5_before {
    return Intl.message(
      'We can distinguish the male from the female by its orange coloration on the head during the breeding season.',
      name: 'screen_1_1_Foto_1_1_5_before',
      desc: '',
      args: [],
    );
  }

  /// `When they have a nest or hatchlings and feel threatened, they sometimes act as they are wounded as in 'drag their wings'.If you observe this behavior, the best thing you can do is to walk away.`
  String get screen_1_1_Foto_1_1_6_after {
    return Intl.message(
      'When they have a nest or hatchlings and feel threatened, they sometimes act as they are wounded as in \'drag their wings\'.If you observe this behavior, the best thing you can do is to walk away.',
      name: 'screen_1_1_Foto_1_1_6_after',
      desc: '',
      args: [],
    );
  }

  /// `The female blends in very well with the sand on the beach when she is stretched out.`
  String get screen_1_1_Foto_1_1_6_before {
    return Intl.message(
      'The female blends in very well with the sand on the beach when she is stretched out.',
      name: 'screen_1_1_Foto_1_1_6_before',
      desc: '',
      args: [],
    );
  }

  /// `Its behavior is similar to the one of the Kentish Plover and we can distinguish it because it has a more accentuated spot on forehead and on the eyes and a yellow ring around the eye.`
  String get screen_1_1_Foto_1_1_7_after {
    return Intl.message(
      'Its behavior is similar to the one of the Kentish Plover and we can distinguish it because it has a more accentuated spot on forehead and on the eyes and a yellow ring around the eye.',
      name: 'screen_1_1_Foto_1_1_7_after',
      desc: '',
      args: [],
    );
  }

  /// `On the beach we can also find a species very similar to the Kentish Plover, which sometimes also nests in the sand: the Little Ringed Plover.`
  String get screen_1_1_Foto_1_1_7_before {
    return Intl.message(
      'On the beach we can also find a species very similar to the Kentish Plover, which sometimes also nests in the sand: the Little Ringed Plover.',
      name: 'screen_1_1_Foto_1_1_7_before',
      desc: '',
      args: [],
    );
  }

  /// `Become a volunteer and participate by recording your observations`
  String get screen_1_1_Foto_1_1_8_after {
    return Intl.message(
      'Become a volunteer and participate by recording your observations',
      name: 'screen_1_1_Foto_1_1_8_after',
      desc: '',
      args: [],
    );
  }

  /// `Help us protect the plover`
  String get screen_1_1_Foto_1_1_8_before {
    return Intl.message(
      'Help us protect the plover',
      name: 'screen_1_1_Foto_1_1_8_before',
      desc: '',
      args: [],
    );
  }

  /// `Send email`
  String get sendEmail {
    return Intl.message(
      'Send email',
      name: 'sendEmail',
      desc: '',
      args: [],
    );
  }

  /// `Send information`
  String get sendInformation {
    return Intl.message(
      'Send information',
      name: 'sendInformation',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `off`
  String get statusOff {
    return Intl.message(
      'off',
      name: 'statusOff',
      desc: '',
      args: [],
    );
  }

  /// `on`
  String get statusOn {
    return Intl.message(
      'on',
      name: 'statusOn',
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

  /// `Touch the button to update the data.`
  String get tapTheIcon {
    return Intl.message(
      'Touch the button to update the data.',
      name: 'tapTheIcon',
      desc: '',
      args: [],
    );
  }

  /// `Role: Technician`
  String get techRole {
    return Intl.message(
      'Role: Technician',
      name: 'techRole',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error`
  String get unknownError {
    return Intl.message(
      'Unknown error',
      name: 'unknownError',
      desc: '',
      args: [],
    );
  }

  /// `This user cannot be deleted, if you want to delete it, contact us`
  String get userCannotBeRemoved {
    return Intl.message(
      'This user cannot be deleted, if you want to delete it, contact us',
      name: 'userCannotBeRemoved',
      desc: '',
      args: [],
    );
  }

  /// `There is no user record corresponding to this identifier. The user may have been deleted.`
  String get userNotFound {
    return Intl.message(
      'There is no user record corresponding to this identifier. The user may have been deleted.',
      name: 'userNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Role: User`
  String get userRole {
    return Intl.message(
      'Role: User',
      name: 'userRole',
      desc: '',
      args: [],
    );
  }

  /// `Verify Email`
  String get verifyEmail {
    return Intl.message(
      'Verify Email',
      name: 'verifyEmail',
      desc: '',
      args: [],
    );
  }

  /// `Resend Verification`
  String get verifyEmailResent {
    return Intl.message(
      'Resend Verification',
      name: 'verifyEmailResent',
      desc: '',
      args: [],
    );
  }

  /// `A verification email has been sent to: `
  String get verifyEmailSent {
    return Intl.message(
      'A verification email has been sent to: ',
      name: 'verifyEmailSent',
      desc: '',
      args: [],
    );
  }

  /// `If you notice any incident related to the Kentish Plover, call: `
  String get warningText112 {
    return Intl.message(
      'If you notice any incident related to the Kentish Plover, call: ',
      name: 'warningText112',
      desc: '',
      args: [],
    );
  }

  /// `Or visit our website: `
  String get webText {
    return Intl.message(
      'Or visit our website: ',
      name: 'webText',
      desc: '',
      args: [],
    );
  }

  /// `Year of birth`
  String get yearOfBirth {
    return Intl.message(
      'Year of birth',
      name: 'yearOfBirth',
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
      Locale.fromSubtags(languageCode: 'ca'),
      Locale.fromSubtags(languageCode: 'es'),
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

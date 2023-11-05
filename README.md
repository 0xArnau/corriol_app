# corriol_app

This project is a mobile application (Android & iOS) called "Corriol APP." Its main purpose is to allow users (volunteers of [GePeC-EdC](https://gepec.cat)) to register observations of the "Corriol camanegre" bird species [[ca]](https://ca.wikipedia.org/wiki/Corriol_camanegre), [[es]](https://es.wikipedia.org/wiki/Charadrius_alexandrinus) & [[en]](https://en.wikipedia.org/wiki/Kentish_plover), and the "Corriol petit" bird species [[ca]](https://ca.wikipedia.org/wiki/Corriol_anellat_petit), [[es]](https://es.wikipedia.org/wiki/Charadrius_dubius) & [[en]](https://en.wikipedia.org/wiki/Little_ringed_plover). Users can record various details, such as the number of birds observed by gender and species, as well as their geographic location.

<p align="center">
   <a href="https://play.google.com/store/apps/details?id=com.corriol_app" target="_blank" rel="noreferrer">
      <img src="https://www.vectorlogo.zone/logos/google_play/google_play-ar21.svg" alt="Play Store" width="200"/>
   </a>
   <a href="https://apps.apple.com/us/app/corriol-app/id6468093371" target="_blank" rel="noreferrer">
      <img src="https://www.vectorlogo.zone/logos/apple_appstore/apple_appstore-ar21.svg" alt="Apple Store" width="200"/>
   </a>
</p>

---

## Dependencies

1. [Flutter](https://docs.flutter.dev/get-started/install)
2. macOS, to be able to build the iOS app
   1. Ruby: [cocoapods](https://guides.cocoapods.org/using/getting-started.html#installation)
   2. [Xcode](https://developer.apple.com/xcode/)
3. [Android Studio](https://developer.android.com/studio)

## Installation & Configuration

To get started with the project, follow these steps:

1. Clone the repository.
2. Add the API_KEYs from [Google Maps](https://console.cloud.google.com/apis/dashboard?) to the .env file:
   1. GOOGLE_MAPS_API_KEY_ANDROID
   2. GOOGLE_MAPS_API_KEY_IOS
3. Firebase service:
   1. **Android**: place the `google-services.json` ([downloaded from the Firebase console, Android app project](https://console.firebase.google.com/)) to `android/app/`
   2. **iOS**: place the `GoogleService-Info.plist` ([downloaded from the Firebase console, iOS app project](https://console.firebase.google.com/)) to `ios/Runner/`

## Documentation

To generate documentation, use `dart doc .`, which will generate HTMLs. These can be accessed directly, but to make the search functionality work, you'll need to create a http server:

```shell
dart pub global activate dhttpd 
dhttpd --path doc/api # starts the server, ctrl-c to exit

dart pub global deactivate dhttpd  
```

## Key Features

- Bird Observation Recording: Users can specify the number of birds observed by gender (males, females, undetermined) and their predators.
- Users can view their records.
- Google Maps Integration: The application utilizes Google Maps to display the geographical location of registered observations.
- Preference Settings: Users can customize their preferences in the app, such as language, mobile data usage and location permission.
- Technicians can view all records (grouped by locality) made by all users and download them as CSV files.

## Build the App

### Android

- [Flutter docs](https://docs.flutter.dev/deployment/android)
- [YT](https://www.youtube.com/watch?v=mUpF8R6Nfcw&list=PLPRFjV_AptwAJ1WTY_xHLw1zq0eHXM__c&index=29) (Recommended)

```shell
mkdir -p ~/.corriol-app/.android

keytool -genkey -v -keystore ~/.corriol-app/.android/debug-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias androiddebugkey
keytool -genkey -v -keystore ~/.corriol-app/.android/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

1. Modify the `version` of `pubspec.yaml`
     1. 1.0.0(version name)+3(version code), at least update the version code every time an update is going to be done on Play Store.
2. Build the app bundle: `flutter build appbundle`

#### Errors

#### Warnings

- This App Bundle contains native code, and you've not uploaded debug symbols. We recommend you upload a symbol file to make your crashes and ANRs easier to analyze and debug
  - [StackOverflow](https://stackoverflow.com/questions/62568757/playstore-error-app-bundle-contains-native-code-and-youve-not-uploaded-debug/68778908#68778908)
  - [YT](https://www.youtube.com/watch?v=nbDjfPbc6hk) (Recommended)
    - The native debug symbols contain an invalid directory __MACOSX. Only Android ABIs are supported.
      - `zip -d symbols.zip "__MACOSX*"`

### iOS

- [Flutter docs](https://docs.flutter.dev/deployment/ios)
- [YT](https://www.youtube.com/watch?v=6QMadUJF78U&list=PLPRFjV_AptwAJ1WTY_xHLw1zq0eHXM__c&index=30)

1. Open the iOS project on xcode (`ios/Runner.xcodeproj`)
   1. In the Signing & Capabilities tab:
      1. Team -> Select the team associated with your registered Apple Developer account. If required, select Add Account…, then update this setting.
2. Generate the `ipa` format using flutter cli
3. [Upload the app bundle to App Store Connect](https://docs.flutter.dev/deployment/ios#upload-the-app-bundle-to-app-store-connect)

```sh
flutter build ipa
```

## Screenshots

<div style="display: flex; justify-content: space-between;">
  <img src="doc/img/home.png" alt="Home" style="width: 30%;">
  <img src="doc/img/handyman.png" alt="Handyman" style="width: 30%;">
  <img src="doc/img/profile.png" alt="Profile" style="width: 30%;">
</div>

<div style="display: flex; flex-wrap: wrap; justify-content: center;">
  <img src="doc/img/kentishPlover.png" alt="Kentish Plover" style="width: 33%; padding: 10px;">
  <img src="doc/img/Contact.png" alt="Contact" style="width: 33%; padding: 10px;">
  <img src="doc/img/RecordObservation.png" alt="Record an observation" style="width: 33%; padding: 10px;">
  <img src="doc/img/ViewObservation.png" alt="View observations" style="width: 33%; padding: 10px;">
</div>

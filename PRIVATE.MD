# How to Set Up the Private Keys

## Firebase - Android

- Download the `google-services.json` file and save it in the `android/app/` directory.

## Firebase - iOS

- Download the `GoogleService-Info.plist` file and save it in the `ios/Runner/` directory.

## Google Maps - Android

- Create the file `android/app/src/main/res/values/strings.xml` and add the following code:

```xml
<resources>
    <!-- Otras cadenas de recursos -->

    <!-- Definir la clave de la API de Google Maps -->
    <string name="GOOGLE_MAPS_API_KEY_ANDROID">GOOGLE_MAPS_API_KEY_ANDROID</string>
</resources>
```

- Change the value of `GOOGLE_MAPS_API_KEY_ANDROID` to your actual API Key.

## Google Maps- iOS

- Create the file `ios/Runner/AppDelegate.swift` and add the following code:

```swift
import UIKit
import Flutter
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("GOOGLE_MAPS_API_KEY_IOS")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

```

- Change the value of `GOOGLE_MAPS_API_KEY_IOS` to your actual API Key.
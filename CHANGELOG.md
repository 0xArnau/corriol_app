# Changelog

All notable changes to this project will be documented in this file.

## [unreleased]

### 🚀 Features

- *(card_widget)* Add semantics & exclude widgets from semantic tree
- *(card_widget)* Exclude widgets from semantic tree
- *(widget_tree)* Add semantics
- *(handyman_page)* Add semantics & exclude widgets from semantic tree
- *(profile_page)* Add semantics & exclude widgets from semantic tree
- *(profile_page)* Exclude widgets from semantic tree
- *(login_register_page)* Add semantics & exclude widgets from semantic tree
- *(corriol_page)* Add semantics & exclude widgets from semantic tree
- *(contact_page)* Add semantics & exclude widgets from semantic tree
- *(my_records_page)* Exclude widgets from semantic tree
- *(login_register_page)* Add semantics & exclude widgets from semantic tree
- *(pdf_view_widget)* Add semantics & exclude widgets from semantic tree. Can download PDF now
- *(login_register_page)* Add semantics
- *(splash)* Exclude widgets from semantic tree
- *(login_register_page)* Add semantics & exclude widgets from semantic tree.
- *(map_button_widget)* Increment touch size
- *(dropdown_button_widget)* Increment touch size
- *(record_observation_page)* Add semantics.

### 💼 Other

- Install `accessibility_tools`
- *(map_button_widget)* Add semantics & exclude widgets from semantic tree.
- *(counter_button_widget)* Add semantics.
- *(pubspec)* Update app version

## [1.1.1] - 2025-01-09

### 🐛 Bug Fixes

- *(DropdownButton)* Update value to use `Species` object, now selecting option returns `Species.XXXXX.name`

### 💼 Other

- Upgrade to `3.27.1` Flutter version
- Update ios related files
- *(Android)* Upgrade version
- `.gitignore`  AppDelegate & strings.xml
- *(android)* Remove errors
- Upgrade version

## [1.1.0] - 2024-08-31

### 🚀 Features

- *(Remove observations)* Add an option for the technicians to remove all observations
- *(Remove observations)* Connect to friestore

### 🐛 Bug Fixes

- *(Firestore roles)* Change the way to get data from firestare, change for loop to where

### 💼 Other

- *(iOS)* Updating minimum iOS deployment target to 12.0
- *(Android)* Update sdk version
- Update app version

### 📚 Documentation

- *(README.md)* Update links to download the app

## [1.0.2] - 2023-10-22

### 🐛 Bug Fixes

- *(iOS)* This build is missing export compliance information
- *(register)* Remove year field
- *(register)* Add more information when the email format is incorrect & add more information relative to the legal checkboxes
- *(iOS)* ITMS-90683: Missing purpose string in Info.plist

### 💼 Other

- Update build number

### 📚 Documentation

- *(README)* Update info regarding iOS build

## [android-v1.0.1] - 2023-10-03

### 🚀 Features

- Add translations
- Add bottom navigation menu
- Add home page
- Add logic for GPS
- Add button to change language
- Add google maps logic
- Show the current position (longitude & latitude)
- *(record observation page)* Start addings buttons
- Add callback
- Finish putting the other counters + translations + images
- Add default value
- Get values
- Save information(record observation) on local storage
- Save the user language as a user settings file on local storage
- *(home)* Add image/icon
- Add a splahs screen
- Add meet the plover page
- Add contact page
- Depending on the internet connectiion type, save the information in one way or another
- Add a button to activate or deactive mobile data
- Add chart to my records
- *(firebase)* Add login, logout, registration, email verification
- Add logout option on verify email page
- Add .env file for android
- Add .env file for iOS
- Add .env file reader
- Add administrativeArea, subAdministrativeArea & locality information
- Add a switch to select the species
- *(register & profile)* Save more information into Firebase Firestore (email, name, age, technician) when registering & show it into the profile page
- *(profile)* Add styles
- Save reports to Firestore (when there is internet connection)
- Get reports from Firestore (when there is internet connection)
- Show handyman page only if the user role is technician
- Add a loading icon on Login/Register page
- Show the place name and not the coordinates
- *(register)* Add legal stuff checkboxes
- *(register)* Add 3 different messages when the checkboxes are 'false'
- Show a button card for each sub administrative area
- Show markers on subabministrative area maps
- Add a dialog, with the report info, when tapping a marker
- Download a .csv file with the reports
- Show a card (opens google map) per each area
- Prevent rotation
- Add a button to download all reports (.csv)
- Change logout icon color
- Add a 'ReportProvider'
- Add a list of colors for the 'Cards' on handyman page
- Afegir traducció: 'error en obtenir la informació'
- El 'switch' de dades mòbils només afecta a les dades mòbils, afegir un camp extra per comprovar la connexió a internet
- Afegir un botó per anar a la configuració de l'aplicació del dispositiu
- Afegir un text per indicar que s'ha de clicar el botó per actualitzar les dades
- Change the field 'age' for the 'year of birth'
- *(record observation)* Change 'submit button' and 'counter button' style
- Add an option to delete user account
- *(delete account)* Add an exception to not delete an email (Play Store testing) added in the .env

### 🐛 Bug Fixes

- Run CircularProgressIndicator only when GPS permission is not granted
- *(splash screen)* View all content (without scroll)
- *(home page)* Remove padding between image(increase size) and text
- *(record information page -> snackbar)* Add translations
- *(splash screen)* Add GePeC logo at the bottom center of the screen
- *(splash screen)* Add transition to home after 1500 ms
- Move the connection check to the beginning of the application
- Save and load the user config
- Pie chart; feat: add legend
- Read the file: 'reports_without_connection'
- When login is done go to AuthPage
- Check if the widget is mounted
- Remove the error -> bottom overflowed by keyboard
- Autologin after email is verified
- *(save record)* Cannot save empty record
- Don't change to Login page when an error appear in Register page
- Add a constructor to MyApp class
- *(profile)* Change the gps value
- Every time record observation is opened, app settings is also opened
- *(register)* Center title
- Use a const to determine the padding on register/login & forgotten pages
- When login/register doesn't appear anymore the navigation arrow
- *(record observation)* Cannot send a report if the address is empty
- *(record observation)* Save the selected location
- Save files on iOS
- Save files on Android
- Use locality instead of sub administrative area due to different results on Android and iOS
- Remove the checkboxes inside the pdf
- Add an 'if mouted' before 'setState'
- Remove print or used logger package instead
- Use for loop instead of forEach
- Add const
- Don't use 'BuildContext' across async gaps
- Add scroll on cards
- Remove '_' from variable name
- Remove the deprecated 'window'
- Remove unnecessary space before GEPEC logo
- Remove unnecessary app info
- Make contact page scrollable
- Add the correct colors
- Save local reports to firestore before getting reports from firestore
- Don't fetch reports from firebase if 'mobileData' variable is false
- *(handyman page)* Show snackbarError when no internet connection
- *(handyman page)* Don't show an empty/null 'all' card
- Add some translations
- Add translations
- Add translations
- Add translations
- *(login/register)* Right overflow
- Add translations
- Gps permission
- Select a valid location after an invalid one
- Add translations for some firabase auth errors
- Remove 'final' keyword from attributes inm report_model
- Minor grammatical error
- Location device permission
- Add auto fetch user reports
- GPS permission
- GPS permission
- Afegir traduccions pels errors de firebase
- Afegir permis de GPS a Android
- Deshabilitar gps & obrir les opcions de l'aplicació del dispositiu
- Canviar l'id dels marcadors del mapa per 'createdAt'
- Guardar fitxers en la carpeta downloads
- Canviar l'id dels marcadors del mapa per 'createdy' + 'createdAt'
- Quan un usuari crea una nova observació s'afegeix automaticament en el 'provider'
- Add 'SingleChildScrollView' toi view long texts
- Set the same padding on all pages
- *(README)* Add App images
- When 'user == null' + add 'INTERNET' Android permission
- Remove 'example' from package name
- Remove unused Android permission
- Change widget used for date
- *(MyRecordsPage)* Remove button to update data + add translations for legend
- *(MyRecordsPage)* Change text when no reports are shown
- Convert email to lowercase

### 💼 Other

- Update packages
- Add logos for SSO
- Add a necessary file to read .env (Android)
- Change the app icon
- Change the app name
- Add .env file example
- Add vscode recomended extensions for this project
- Afegir diagrames
- Add auto signing key
- Increment code version

### 🚜 Refactor

- Add each button in a widget/file
- *(record observation page)* Add scroll
- Add a class for user config
- Remove unused imports
- Show user info
- Change where to start the UserProvider & add some new fields to UserProvider
- *(user preferences & profile page)* Use the package 'shared_preferences' to save the user preferences & change how to get the data in profile
- Change how to get the lang info
- *(home page)* Removed unused code
- *(report chart)* Change the way to get the reports
- Make the page scrollable
- *(login & register)* Remove unused .dart files
- *(button widget)* Remove unused .dart files
- *(language widget)* Remove unused .dart files
- *(mobile data widget)* Remove unused .dart files
- *(text field widget)* Remove unused .dart files
- *(user config class & notifier)* Remove unused .dart files
- Rename file_io_class -> file_io_controller
- Rename geolocation_class -> geolocation_controller
- Rename sss_button_widget -> sso_button_widget
- *(profile)* Remove unused code; add some const
- *(currentPositionNotifier)* Remove the currentPositionNotifier and use the UserProvider()
- Remove the notifiers
- Change firebase_snackbar to my_snackbar
- Rename legal docs
- Change the switch to tabs
- Change 'core' to 'utils' & move 'my_snackbar.dart' to 'utils'
- Change the snackbar name to snackbarError
- Use the 'ReportProvider'
- Change the type of the 'blackButton' &  remove the 'context' parameter

### 📚 Documentation

- *(README)* Explain how to create an .apk
- *(README)* Add more information about pacakges
- Add dartdocs for user_provider
- Add dartdocs for my_snackbar
- Add dartdocs for constants
- Dartdocs for user_provider
- Add dartdocs for report_model
- Add dartdocs for user_model
- Add dartdocs for user_preferences_model
- Add dartdocs for auth_controller
- Add dartdocs for file_io_controller
- Add dartdocs for geolocation_controller
- Add dartdocs for map_controller
- Add dartdocs for report_controller
- Add dartdocs for user_preferences_controller
- Add dartdocs for l10n
- Add dartdocs for auth_page
- Add dartdocs for forgot_password_page
- Add dartdocs for login_register_page
- Add dartdocs for verify_email_page
- Add dartdocs for report_map_page
- Add dartdocs
- Add more documentation to README.md
- Add how to install/configure the project
- *(README)* Add App images
- *(README)* Update info regarding Android build

<!-- generated by git-cliff -->

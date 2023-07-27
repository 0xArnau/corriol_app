import 'package:corriol_app/controllers/file_io_controller.dart';
import 'package:flutter/material.dart';

// Colors

/// Color to stand out texts
const kColorText = Color.fromRGBO(0, 30, 255, 1);

/// Color for the [corriol_page] in the card of the [home_page]
const kColorScreenCorriol = Color.fromRGBO(255, 0, 132, 1);

/// Color for the [contact_page] in the card of the [home_page]
const kColorScreenContact = Color.fromRGBO(255, 0, 255, 1);

/// Color for the [record_observation_page] in the card of the [home_page]
const kColorScreenReport = Color.fromRGBO(0, 193, 118, 1);

/// Color for the rectangles of the [record_observation_page]
const kColorScreenMyReports = Color.fromRGBO(253, 223, 1, 1);

/// Color for the in the card of the [home_page]
const kColorDropDown = Color.fromRGBO(242, 217, 116, 1);

/// Color to stand out icons
const kColorIcon = kColorText;

const kColorPrimaryBlue = Colors.blue;
const kColorPrimaryGrey = Colors.grey;
const kColorRedCard = Colors.red;
const kColorPurpleCard = Colors.purple;
const kColorGreenCard = Colors.green;
const kColorYellowCard = Colors.yellow;
const kColorPinkCard = Colors.pink;
const kColorCyanCard = Colors.cyan;

/// Used for displaying a legend, on [my_records_page], with colors representing different strings.
const kColorList = {
  'femelles': kColorYellowCard,
  'polls': kColorPurpleCard,
  'mascles': kColorGreenCard,
  'indeterminat': kColorPinkCard,
  'gossos': kColorCyanCard,
  'gats': kColorRedCard,
};

// Paddings
const kDouble10 = 10.0;
const kDouble15 = 15.0;
const kDouble20 = 20.0;
const kDouble25 = 25.0;

const kDoublePaddingCardImageText = 40.0;
const kDoublePaddingGridViewText = 20.0;

const kDoublePaddingFloatingActionButtonH = 100.0;
const kDoublePaddingFloatingActionButtonV = 150.0;

const kDoublePaddingMyButtonAndMyTextField = 15.0;
const kDoublePaddingBasic = 30.0;

// Border Radius
const kDoubleBorderRadiusButtons = 15.0;

// Text size & weigth
const kTextStylePageTitle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

// Files
FileIoController kFileReportsWithoutConnection =
    FileIoController(fileName: 'reports_without_connection.json');
FileIoController kFileReports = FileIoController(fileName: 'reports.json');

/// Represent the species of a bird
enum Species {
  corriolCamanegre,
  corriolPetit,
}

/// Extension on the [Species] enum providing [SpeciesExtension.valueOf].
extension SpeciesExtension on Species {
  static Species valueOf(String value) {
    return value == 'Species.corriolCamanegre'
        ? Species.corriolCamanegre
        : Species.corriolPetit;
  }
}

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

const kListColorReports = [
  Color.fromARGB(255, 169, 198, 237),
  Color.fromARGB(255, 57, 114, 253),
  Color.fromARGB(255, 116, 94, 165),
  Color.fromARGB(255, 9, 7, 83),
  Color.fromARGB(255, 202, 201, 201),
  Color.fromARGB(255, 20, 17, 101),
  Color.fromARGB(255, 241, 209, 220),
  Color.fromARGB(255, 196, 44, 124),
  Color.fromARGB(255, 85, 139, 105),
  Color.fromARGB(255, 113, 146, 95),
  Color.fromARGB(255, 60, 154, 175),
  Color.fromARGB(255, 244, 166, 154),
  Color.fromARGB(255, 111, 14, 4),
  Color.fromARGB(255, 25, 1, 27),
  Color.fromARGB(255, 200, 240, 138),
  Color.fromARGB(255, 236, 217, 81),
  Color.fromARGB(255, 246, 188, 59),
  Color.fromARGB(255, 94, 85, 39),
  Color.fromARGB(255, 165, 245, 241),
  Color.fromARGB(255, 185, 203, 128),
  Color.fromARGB(255, 149, 229, 197),
];

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

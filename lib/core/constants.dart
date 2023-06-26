import 'package:corriol_app/classes/file_io_class.dart';
import 'package:flutter/material.dart';

// Colors
const kColorPrimaryBlue = Colors.blue;
const kColorPrimaryGrey = Colors.grey;
const kColorRedCard = Colors.red;
const kColorPurpleCard = Colors.purple;
const kColorGreenCard = Colors.green;
const kColorYellowCard = Colors.yellow;
const kColorPinkCard = Colors.pink;
const kColorCyanCard = Colors.cyan;
const kColorList = {
  'femelles': kColorYellowCard,
  'polls': kColorPurpleCard,
  'mascles': kColorGreenCard,
  'indeterminat': kColorPinkCard,
  'gossos': kColorCyanCard,
  'gats': kColorRedCard
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
const kDoublePaddingBasic = 10.0;

// Text size & weigth
const kTextStylePageTitle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

// Files
FileIoClass kFileReportsWithoutConnection =
    FileIoClass(fileName: 'reports_without_connection.json');
FileIoClass kFileReports = FileIoClass(fileName: 'reports.json');

// Enum
enum Species {
  corriolCamanegre,
  corriolPetit,
}
extension SpeciesExtension on Species {
  static Species valueOf(String value) {
    return Species.values
        .firstWhere((element) => element.toString().split('.').last == value);
  }
}

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

// Paddings
const kDouble10 = 10.0;
const kDouble15 = 15.0;
const kDouble20 = 20.0;
const kDouble25 = 25.0;

const kDoublePaddingCardImageText = 40.0;
const kDoublePaddingGridViewText = 20.0;

const kDoublePaddingFloatingActionButtonH = 100.0;
const kDoublePaddingFloatingActionButtonV = 150.0;

// Text size & weigth
const kTextStylePageTitle =
    TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

// Files
final FileIoClass cfg = FileIoClass(fileName: 'user_config.cfg');
FileIoClass reportsWithoutConnectionfile =
    FileIoClass(fileName: 'reports_without_connection.json');
FileIoClass reportsFile = FileIoClass(fileName: 'reports.json');

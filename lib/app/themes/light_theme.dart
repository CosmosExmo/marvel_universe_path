import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0XFF202020),
  indicatorColor: const Color(0xFFec1c23),
  primaryColor: const Color(0xFFec1c23),
  selectedRowColor: const Color.fromARGB(137, 110, 109, 109),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Color.fromARGB(232, 229, 229, 229),
  ),
  iconTheme: const IconThemeData(
    color: Color.fromARGB(232, 229, 229, 229),
  ),
  fontFamily: GoogleFonts.ubuntu().fontFamily,
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Color.fromARGB(232, 229, 229, 229),
    ),
    bodyText2: TextStyle(
      color: Color.fromARGB(232, 229, 229, 229),
      fontSize: 24,
    ),
    subtitle1: TextStyle(
      color: Color.fromARGB(232, 229, 229, 229),
      fontSize: 20,
    ),
  ),
);

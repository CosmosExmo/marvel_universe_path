import 'package:flutter/material.dart';
import 'package:marvel_universe_path/app/themes/light_theme.dart';
import 'package:marvel_universe_path/views/home_view/home_view.dart';

class MarvelUniversePath extends StatelessWidget {
  const MarvelUniversePath({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marvel Universe Path',
      theme: lightTheme,
      home: const HomeView(),
    );
  }
}
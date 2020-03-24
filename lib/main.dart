import 'package:flutter/material.dart';

import 'dice_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp();

  MyApp.forDesignTime();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Random Numbers',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DicePage(title: 'Simple Rnadom Numbers'),
    );
  }
}

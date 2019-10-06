import 'package:flutter/material.dart';
import 'package:my_meteo/screens/loading_screen.dart';
import 'package:my_meteo/utilities/constants.dart';

void main() => runApp(MyMeteo());

class MyMeteo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: kBackgroundColor,
        scaffoldBackgroundColor: kBackgroundColor,
      ),
      home: LoadingScreen(),
    );
  }
}

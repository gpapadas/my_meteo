import 'package:flutter/material.dart';

const kTempTextStyle = TextStyle(
  //fontFamily: 'Spartan MB',
  fontSize: 60.0,
);

const kMessageTextStyle = TextStyle(
  //fontFamily: 'Spartan MB',
  fontSize: 18.0,
  //fontWeight: FontWeight.w200,
);

const kTimeTextStyle = TextStyle(
  //fontFamily: 'Spartan MB',
  fontSize: 13.0,
);

const kButtonTextStyle = TextStyle(
  fontSize: 30.0,
  //fontFamily: 'Spartan MB',
);

const kConditionTextStyle = TextStyle(
  fontSize: 50.0,
);

const kTextFieldInputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  icon: Icon(
    Icons.location_city,
    color: Colors.white,
  ),
  hintText: 'Enter City Name',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(const Radius.circular(10.0)),
    borderSide: BorderSide.none,
  ),
);

const kBackgroundColor = Color(0xFF000C2E);
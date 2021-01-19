
import 'package:flutter/material.dart';


final dazzledBlue = 0xFF3C587C;
final carolBlue = 0xFF4C94BD;
final azureBlue = 0xFFE6FBFF;
final orangeSoda = 0xFFEC5732;
final orangeIcons = 0xFFF77F00;
final gunmetal = 0xFF000819;


final labelStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
  fontSize: 18,
);

final boxDecorationStyle = BoxDecoration(
  color: Color(gunmetal),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Color(dazzledBlue),
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final hintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final textFieldStyle = TextStyle(
  color: Colors.white,
  fontSize: 18,
  fontFamily: 'OpenSans',
);
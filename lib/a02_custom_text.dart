
import 'package:flutter/material.dart';

Widget normalText( {String? text, Color? color, double? size} ){
  return Text('$text', style: TextStyle(fontSize: size, color: color, fontWeight: FontWeight.w800),);
}


Widget headingText( {String? text, Color? color, double? size} ){
  return Text('$text', style: TextStyle(fontSize: size, color: color, fontWeight: FontWeight.bold),);
}


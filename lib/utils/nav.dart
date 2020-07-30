import 'package:flutter/material.dart';

Future push(BuildContext context, Widget page) async {
  return Navigator.push(context,
      MaterialPageRoute(builder: (BuildContext context) {
    return page;
  }));
}

Future pushReplace(BuildContext context, Widget page) async {
  return Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (BuildContext context) {
    return page;
  }));
}

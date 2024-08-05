import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;


  const Responsive({
    Key? key,
    required this.mobile,
    required this.tablet,

  }) : super(key: key);


  // bool isTablet = MediaQuery.of(context).size.width >= 500 ? true:false;


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
      if (size.width >= 500) {
      return tablet;
    }
    else {
      return mobile;
    }
  }
}

import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;
  final Widget desktop2;

  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop2,
    required this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 576;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 576 &&
      MediaQuery.of(context).size.width <= 1040;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1040 &&
      MediaQuery.of(context).size.width <= 1180;

  static bool isDesktop2(BuildContext context) =>
      MediaQuery.of(context).size.width > 1180;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (size.width > 1180) {
      return desktop2;
    } else if (size.width > 1040) {
      return desktop;
    } else if (size.width >= 576 && tablet != null) {
      return tablet!;
    } else {
      return mobile;
    }
  }
}

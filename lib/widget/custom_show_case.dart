import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class CustomShowCase extends StatelessWidget {
  const CustomShowCase({
    Key? key,
    required this.description,
    required this.globalkey,
    required this.child,
  }) : super(key: key);
  final String description;
  final GlobalKey globalkey;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Showcase(
      key: globalkey,
      description: description,
      child: child,
      
    );
  }
}

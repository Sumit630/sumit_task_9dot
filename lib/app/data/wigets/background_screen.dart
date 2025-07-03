import 'package:flutter/material.dart';
import 'package:sumittask9dot/app/data/res/app.export.dart';

import '../res/app_icon_path.dart';

class BackgroundScreen extends StatelessWidget {
  final Widget child;

  const BackgroundScreen({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: hg,
      width: wd,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill, image: AssetImage(AppImage.backgroundImage))),
      child: child,
    );
  }
}

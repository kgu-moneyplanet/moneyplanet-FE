import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/presentaion/register/view/register_screen.dart';

import '../../presentaion/register/view/register_ocr_screen.dart';

SpeedDial floatingDialButton(BuildContext context) {
  return SpeedDial(
    animatedIcon: AnimatedIcons.add_event,
    backgroundColor: neutral_400,
    overlayColor: Colors.black,
    overlayOpacity: 0.5,
    spacing: 12,
    spaceBetweenChildren: 12,
    foregroundColor: Colors.white,
    buttonSize: Size(60, 60),
    children: [
      SpeedDialChild(
        child: const Icon(Icons.receipt_long, color: Colors.white),
        backgroundColor: Colors.blue[200],
        label: '붙여넣기',
        onTap:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => RegisterScreen()),
            ),
      ),
      SpeedDialChild(
        child: const Icon(Icons.camera_alt, color: Colors.white),
        backgroundColor: Colors.blue[200],
        label: '영수증 촬영',
        onTap:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => RegisterOcrScreen()),
            ),
      ),
      SpeedDialChild(
        child: const Icon(Icons.edit, color: Colors.white),
        backgroundColor: Colors.blue[200],
        label: '직접 작성',
        onTap:
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => RegisterScreen()),
            ),
      ),
    ],
  );
}

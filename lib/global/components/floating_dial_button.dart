import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/presentaion/register/view/register_screen.dart';

import '../../presentaion/register/view/register_ocr_screen.dart';

SpeedDial floatingDialButton(BuildContext context, VoidCallback onRegisterSuccess) {
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
        child: const Icon(Icons.camera_alt, color: Colors.white),
        backgroundColor: Colors.blue[200],
        label: '영수증 촬영',
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => RegisterOcrScreen()),
            ),
      ),
      SpeedDialChild(
        child: const Icon(Icons.edit, color: Colors.white),
        backgroundColor: Colors.blue[200],
        label: '직접 작성',
        onTap: () async {
          final result = await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            enableDrag: false,
            isDismissible: false,
            builder: (context) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.9,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: RegisterScreen(isIncome: true),
              );
            },
          );

          onRegisterSuccess();
        },
      ),
    ],
  );
}

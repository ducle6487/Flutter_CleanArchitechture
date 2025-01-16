import 'package:flutter/material.dart';

enum AppIcons {
  unknown(Icons.question_mark),
  dropdown(Icons.keyboard_arrow_down_sharp),
  back(Icons.arrow_back_outlined),
  checked(Icons.check),
  arrowDropDown(Icons.arrow_drop_down),
  signOut(Icons.logout),
  camera(Icons.camera_alt_outlined),
  close(Icons.close),
  eyeOff(Icons.visibility_off),
  eyeOn(Icons.visibility),
  add(Icons.add),
  ;

  final IconData icon;

  const AppIcons(this.icon);
}

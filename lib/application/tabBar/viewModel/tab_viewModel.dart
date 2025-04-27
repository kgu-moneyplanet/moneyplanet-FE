import 'package:flutter/material.dart';
import '../model/tab_model.dart';

class TabViewModel {
  final TabModel model = TabModel();

  int get selectedIndex => model.selectedIndex;
  List<Widget> get pages => model.pages;
  List<BottomNavigationBarItem> get navBarItems => model.navBarItems;

  void updateIndex(int index) {
    model.selectedIndex = index;

  }

  Widget getCurrentPage() {
    return pages[selectedIndex];
  }
}
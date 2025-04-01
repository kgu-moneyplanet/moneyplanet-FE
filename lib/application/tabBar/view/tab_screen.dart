import 'package:flutter/material.dart';
import '../viewmodel/tab_viewmodel.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final TabViewModel viewModel = TabViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: viewModel.getCurrentPage(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: viewModel.navBarItems,
        currentIndex: viewModel.selectedIndex,
        onTap: (index) {
          setState(() {
            viewModel.updateIndex(index);
          });
        },
      ),
    );
  }
}
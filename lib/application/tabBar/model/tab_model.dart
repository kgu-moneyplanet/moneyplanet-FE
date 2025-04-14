import 'package:flutter/material.dart';
import 'package:money_planet/presentaion/register/view/login_screen.dart';

import '../../../presentaion/chart/view/chart_screen.dart';
import '../../../presentaion/diary/view/diary_screen.dart';
import '../../../presentaion/home/view/home_screen.dart';
import '../../../presentaion/myPage/view/mypage_screen.dart';
import '../../../presentaion/register/view/register_screen.dart';

class TabModel {
  int selectedIndex = 0;

  final List<Widget> pages = [
    const HomeScreen(),
    const DiaryScreen(),
    const LoginScreen(),
    const ChartScreen(),
    const MyPageScreen(),
  ];

  final List<BottomNavigationBarItem> navBarItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
    BottomNavigationBarItem(icon: Icon(Icons.book), label: '가계부'),
    BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: '등록'),
    BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: '통계'),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이페이지'),
  ];
}

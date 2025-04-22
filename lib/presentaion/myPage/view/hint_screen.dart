import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/textStyles.dart';
import '../../../global/theme/colors.dart';


import 'hint_abc_screen.dart';
import 'hint_consumetype_screen.dart';

class HintScreen extends StatefulWidget {
  const HintScreen({super.key});

  @override
  _HintScreenState createState() => _HintScreenState();
}

class _HintScreenState extends State<HintScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('도움말',style: customTextStyle(fontFamily: Pretendard_Semibold_24,color: Colors.black),),
        bottom: TabBar(
          controller: _tabController,
            labelColor: primary_400,
            unselectedLabelColor: neutral_200,
            indicatorColor: primary_400,
          labelStyle: customTextStyle(fontFamily: Pretendard_Bold_18),
          unselectedLabelStyle: customTextStyle(fontFamily: Pretendard_Bold_18),
          tabs: [
            Tab(text: '소비 성향 유형'),
            Tab(text: 'ABC란?'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          HintConsumeTypeScreen(),
          HintABCScreen(),
        ],
      ),
    );
  }
}

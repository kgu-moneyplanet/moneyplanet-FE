import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/presentaion/home/view/home_first_section.dart';
import 'package:money_planet/presentaion/home/view/home_third_section.dart';

import '../../../global/planet_list.dart';
import '../../../network/Daily/Response/LWTWResponseDTO.dart';
import '../../../network/User/Response/UserInfoResponseDTO.dart';
import '../viewModel/home_viewModel.dart';
import 'home_second_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel viewModel = HomeViewModel();
  UserInfoData? userInfo;
  bool isLoading = true;
  PlanetModel? planetModel;
  LWTWResponseData? comparisonData;
  late var dailyCategoryStats;

  int getWeekNumber(DateTime date) {
    final beginningOfYear = DateTime(date.year, 1, 1);
    final daysDifference = date.difference(beginningOfYear).inDays;
    return ((daysDifference + beginningOfYear.weekday) / 7).ceil();
  }

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    final (user, planet) = await viewModel.getUserInfoWithPlanet();

    final now = DateTime.now();
    final weekNum = getWeekNumber(now);
    final year = now.year;
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final DailyCategoryStats = await viewModel.fetchDailyCategoryStats(today);

    final comparisonResponse = await viewModel.fetchLWTWComparison(
      year: year,
      weekNum: weekNum,
    );

    setState(() {
      userInfo = user;
      planetModel = planet;
      comparisonData = comparisonResponse?.data;
      isLoading = false;
      dailyCategoryStats = DailyCategoryStats;
    });
  }

  @override
  Widget build(BuildContext context) {
    final planetModel = viewModel.getPlanetModelByCode(userInfo?.planet);

    return Scaffold(
      backgroundColor: neutral_900,
      body: SafeArea(
        child:
            isLoading
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                  child: Column(
                    children: [
                      HomeFirstSection(planetModel: planetModel!),

                      SizedBox(height: 40),

                      HomeSecondSection(
                        planetModel: planetModel!,
                        comparisonData: comparisonData,
                        planetTarget: userInfo!.target,
                      ),

                      SizedBox(height: 40),

                      HomeThirdSection(viewModel: viewModel),

                      SizedBox(height: 50),
                    ],
                  ),
                ),
      ),
    );
  }
}

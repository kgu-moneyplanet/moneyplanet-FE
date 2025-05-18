import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/presentaion/home/view/home_first_section.dart';
import 'package:money_planet/presentaion/home/view/home_third_section.dart';

import '../../../global/planet_list.dart';
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

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  Future<void> fetchUserInfo() async {
    final (user, planet) = await viewModel.getUserInfoWithPlanet();
    setState(() {
      userInfo = user;
      planetModel = planet;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final planetModel = viewModel.getPlanetModelByCode(userInfo?.planet);

    return Scaffold(
      backgroundColor: neutral_900,
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Column(
            children: [
              HomeFirstSection(planetModel: planetModel!,),

              SizedBox(height: 40),

              HomeSecondSection(),

              SizedBox(height: 40),

              HomeThirdSection(),

              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

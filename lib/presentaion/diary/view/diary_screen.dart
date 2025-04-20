// TODO: - 코드 정리 필요

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_planet/presentaion/diary/view/diary_list_screen.dart';
import 'package:money_planet/presentaion/diary/view/empty_diary_screen.dart';
import 'package:money_planet/presentaion/register/view/register_ocr_screen.dart';
import 'package:money_planet/presentaion/register/view/register_screen.dart';

import '../../../global/theme/colors.dart';
import '../../../global/theme/textStyles.dart';
import '../model/diary_model.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  int selectedMonth = DateTime.now().month;
  String selectedView = 'Daily';

  @override
  Widget build(BuildContext context) {
    // 필터링된 데이터만 가져오기
    final filteredData =
        DiaryMockData.where(
          (item) => item.date.month == selectedMonth,
        ).toList();

    // 날짜별로 그룹핑된 Map 생성
    final groupedData = groupByDate(filteredData);

    return Scaffold(
      backgroundColor: neutral_900,
      floatingActionButton: FloatingActionButton(
        onPressed: () => onTapWriteDiaryButton(context), // context 꼭 전달!
        backgroundColor: primary_400,
        child: Icon(Icons.add, color: Colors.white, size: 50),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 헤더부분
              SizedBox(
                height: 52,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 28),
                    Text(
                      "가계부",
                      style: customTextStyle(
                        fontFamily: Pretendard_Bold_28,
                        color: Colors.white,
                      ),
                    ),

                    Spacer(),

                    IconButton(
                      onPressed: () {
                        print("tapped bell");
                      },
                      icon: Image.asset(
                        'lib/global/assets/images/icons/bell_01.png',
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        print("tapped help");
                      },
                      icon: Image.asset(
                        'lib/global/assets/images/icons/help_circle.png',
                      ),
                    ),

                    SizedBox(width: 28),
                  ],
                ),
              ),

              SizedBox(height: 29),

              // 가계부
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 달 바꾸는 부분 & 달력 아이콘
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 30,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => changeMonth(-1),
                                icon: const Icon(Icons.chevron_left),
                              ),
                              Text(
                                "$selectedMonth월",
                                style: customTextStyle(
                                  fontFamily: Pretendard_Semibold_24,
                                  color: neutral_1100,
                                ),
                              ),
                              IconButton(
                                onPressed: () => changeMonth(1),
                                icon: const Icon(Icons.chevron_right),
                              ),
                            ],
                          ),

                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(26),
                                color: primary_200,
                              ),
                              width: 48,
                              height: 48,
                              child: IconButton(
                                onPressed: () {
                                  print("달력버튼 클릭");
                                },
                                iconSize: 24,
                                icon: Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 지출
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          Text(
                            "지출",
                            style: customTextStyle(
                              fontFamily: Pretendard_Semibold_16,
                              color: neutral_400,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "475,180 원",
                            style: customTextStyle(
                              fontFamily: Pretendard_Medium_24,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),

                    // 수입
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          SizedBox(width: 10),
                          Text(
                            "수입",
                            style: customTextStyle(
                              fontFamily: Pretendard_Semibold_16,
                              color: neutral_400,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "0 원",
                            style: customTextStyle(
                              fontFamily: Pretendard_Medium_24,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),

                    SizedBox(height: 25),

                    // 구분선
                    Container(
                      height: 12,
                      width: double.infinity,
                      color: neutral_100,
                    ),

                    SizedBox(height: 35),

                    // 리스트 보여주는 곳
                    groupedData.isEmpty
                        ? EmptyDiaryScreen()
                        : Column(
                          children: [
                            // daily, weekly, monthly 선택 버튼
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  for (var viewType in [
                                    'Daily',
                                    'Weekly',
                                    'Monthly',
                                  ])
                                    ElevatedButton(
                                      onPressed: () => changeView(viewType),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            selectedView == viewType
                                                ? primary_400
                                                : primary_050,
                                        foregroundColor:
                                            selectedView == viewType
                                                ? Colors.white
                                                : primary_400,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                          side: const BorderSide(
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        viewType,
                                        style: customTextStyle(
                                          fontFamily: Pretendard_Semibold_18,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            DiaryListScreen(groupedData: groupedData),
                          ],
                        ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeMonth(int delta) {
    setState(() {
      selectedMonth += delta;
      if (selectedMonth < 1) selectedMonth = 1;
      if (selectedMonth > 12) selectedMonth = 12;
    });
  }

  void changeView(String view) {
    setState(() {
      selectedView = view;
    });
  }

  // 날짜별로 그룹핑한 Map 생성 함수
  Map<String, List<DiaryModel>> groupByDate(List<DiaryModel> data) {
    Map<String, List<DiaryModel>> grouped = {};

    for (var item in data) {
      final dateKey = DateFormat('yyyy-MM-dd').format(item.date);
      grouped.putIfAbsent(dateKey, () => []).add(item);
    }

    // 최신 날짜가 위에 오도록 정렬
    final sortedEntries =
        grouped.entries.toList()..sort((a, b) => b.key.compareTo(a.key));

    return Map.fromEntries(sortedEntries);
  }

  //하단에 + 플로팅버튼 클릭시 이벤트
  Future onTapWriteDiaryButton(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      showDragHandle: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: SizedBox(
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Wrap(
                  spacing: 30,
                  runSpacing: 20,
                  alignment: WrapAlignment.center,
                  children: [
                    tapFloatingActionButton(
                      icon: Icons.receipt_long,
                      label: '영수증 등록',
                      onTap: () {
                        Navigator.pop(context); // 바텀시트 닫기
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => RegisterScreen()),
                        );
                      },
                    ),
                    tapFloatingActionButton(
                      icon: Icons.camera_alt,
                      label: '사진 촬영',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RegisterOcrScreen(),
                          ),
                        );
                      },
                    ),
                    tapFloatingActionButton(
                      icon: Icons.edit,
                      label: '직접 작성',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => RegisterScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget tapFloatingActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue[200],
            ),
            child: Icon(icon, size: 30, color: Colors.white),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}

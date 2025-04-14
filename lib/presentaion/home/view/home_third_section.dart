import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';
import 'package:money_planet/presentaion/diary/model/diary_model.dart';

import '../../../global/components/consumption_item.dart';

class HomeThirdSection extends StatefulWidget {
  const HomeThirdSection({super.key});

  @override
  State<HomeThirdSection> createState() => HomeThirdSectionState();
}

class HomeThirdSectionState extends State<HomeThirdSection> {
  int selectedMonth = DateTime.now().month;
  String selectedView = 'Daily';

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 23),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 달 바꾸는 부분 & 자세히 보기
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "자세히보기",
                      style: customTextStyle(
                        fontFamily: Pretendard_Medium_12,
                        color: neutral_300,
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

            SizedBox(height: 20),

            // daily, weekly, monthly 선택 버튼
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var viewType in ['Daily', 'Weekly', 'Monthly'])
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
                          borderRadius: BorderRadius.circular(6),
                          side: const BorderSide(color: Colors.blue),
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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("9일 오늘", style: TextStyle(color: Colors.grey[600])),
            ),

            // 구분선
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Divider(),
            ),

            // 리스트 보여주는 곳
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: DiaryMockData.map((item) => ConsumptionItem(item: item)).toList(),
              ),
            ),

            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}

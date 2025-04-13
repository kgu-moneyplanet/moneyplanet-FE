import 'package:flutter/material.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () => changeMonth(1),
                        icon: const Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                  TextButton(onPressed: () {}, child: const Text("자세히보기")),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var view in ['Daily', 'Weekly', 'Monthly'])
                    ElevatedButton(
                      onPressed: () => changeView(view),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            selectedView == view ? Colors.blue : Colors.white,
                        foregroundColor:
                            selectedView == view ? Colors.white : Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: Colors.blue),
                        ),
                      ),
                      child: Text(view),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              Text("9일 오늘", style: TextStyle(color: Colors.grey[600])),
              const Divider(),
              Column(
                children: const [
                  ConsumptionItem(
                    icon: Icons.ramen_dining,
                    title: "소비내역",
                    subtitle: "식비",
                    amount: "- 20,000원",
                  ),
                  ConsumptionItem(
                    icon: Icons.local_cafe,
                    title: "CU",
                    subtitle: "카페/간식",
                    amount: "- 3,500원",
                  ),
                  ConsumptionItem(
                    icon: Icons.shopping_bag,
                    title: "쇼핑몰",
                    subtitle: "패션/쇼핑",
                    amount: "- 60,000원",
                  ),
                  ConsumptionItem(
                    icon: Icons.list_alt,
                    title: "다이소",
                    subtitle: "생활",
                    amount: "- 5,000원",
                  ),
                  ConsumptionItem(
                    icon: Icons.local_shipping,
                    title: "택시",
                    subtitle: "교통",
                    amount: "- 5,800원",
                  ),
                  ConsumptionItem(
                    icon: Icons.liquor,
                    title: "PC방",
                    subtitle: "여가생활",
                    amount: "- 2,000원",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

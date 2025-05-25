import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';

import '../../../global/components/daily_category_item.dart';
import '../../../network/Daily/Response/DailyCategoryResponseDTO.dart';
import '../../diary/view/diary_calendar_screen.dart';
import '../../diary/view/empty_diary_screen.dart';
import '../viewModel/home_viewModel.dart';

class HomeThirdSection extends StatefulWidget {
  final HomeViewModel viewModel;

  const HomeThirdSection({super.key, required this.viewModel});

  @override
  State<HomeThirdSection> createState() => HomeThirdSectionState();
}

class HomeThirdSectionState extends State<HomeThirdSection> {
  int selectedMonth = DateTime.now().month;
  String selectedView = 'Daily';
  final formatter = NumberFormat('#,###');

  List<CategoryStatDtoList> _expenseStats = [];
  List<CategoryStatDtoList> _incomeStats = [];

  String _dateDisplay = '';

  @override
  void initState() {
    super.initState();
    fetchStats();
  }

  void changeMonth(int delta) {
    setState(() {
      selectedMonth += delta;
      if (selectedMonth < 1) selectedMonth = 1;
      if (selectedMonth > 12) selectedMonth = 12;
    });
    fetchStats();
  }

  void changeView(String view) {
    setState(() {
      selectedView = view;
    });
    fetchStats();
  }

  String formatAmount(int amount) {
    return formatter.format(amount);
  }

  Future<void> fetchStats() async {
    try {
      final now = DateTime.now();
      DailyCategoryResponseDTO? result;

      if (selectedView == 'Daily') {
        final today = DateFormat('yyyy-MM-dd').format(now);
        result = await widget.viewModel.fetchDailyCategoryStats(today);
        _dateDisplay = "${now.day}일 오늘";
      } else if (selectedView == 'Weekly') {
        final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        final endOfWeek = startOfWeek.add(const Duration(days: 6));
        final weekNum =
            ((now.difference(DateTime(now.year, 1, 1)).inDays +
                        DateTime(now.year, 1, 1).weekday) /
                    7)
                .ceil();
        result = await widget.viewModel.fetchWeeklyCategoryStats(
          now.year,
          weekNum+1,
        );
        _dateDisplay =
            "${DateFormat('M월 d일').format(startOfWeek)} ~ ${DateFormat('M월 d일').format(endOfWeek)}";
      } else if (selectedView == 'Monthly') {
        result = await widget.viewModel.fetchMonthlyCategoryStats(
          now.year,
          selectedMonth,
        );
        _dateDisplay = "${selectedMonth}월 전체";
      }

      if (result != null) {
        final data = result.data.categoryStatDtoList;

        final income = data.where((e) => e.categoryName == '월급').toList();
        final expense = data.where((e) => e.categoryName != '월급').toList();

        setState(() {
          _incomeStats = income;
          _expenseStats = expense;
        });
      }
    } catch (e) {
      print("Error fetching stats: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalIncome = _incomeStats.fold(0, (sum, e) => sum + e.amount);
    final totalExpense = _expenseStats.fold(0, (sum, e) => sum + e.amount);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Month selector
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
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    color: primary_200,
                  ),
                  width: 44,
                  height: 44,
                  child: IconButton(
                    onPressed:
                        () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DiaryCalendarScreen(),
                      ),
                    ),
                    iconSize: 24,
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// Expense
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Text(
                  "지출",
                  style: customTextStyle(
                    fontFamily: Pretendard_Semibold_16,
                    color: neutral_400,
                  ),
                ),
                const Spacer(),
                Text(
                  "${formatAmount(totalExpense)} 원",
                  style: customTextStyle(
                    fontFamily: Pretendard_Medium_24,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),

          /// Income
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Text(
                  "수입",
                  style: customTextStyle(
                    fontFamily: Pretendard_Semibold_16,
                    color: neutral_400,
                  ),
                ),
                const Spacer(),
                Text(
                  "${formatAmount(totalIncome)} 원",
                  style: customTextStyle(
                    fontFamily: Pretendard_Medium_24,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// View Type Buttons
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
                          selectedView == viewType ? primary_400 : primary_050,
                      foregroundColor:
                          selectedView == viewType ? Colors.white : primary_400,
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

          /// Date Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              _dateDisplay,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Divider(),
          ),

          /// Combined List View
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child:
                (_incomeStats.isEmpty && _expenseStats.isEmpty)
                    ? EmptyDiaryScreen()
                    : Column(
                      children: [
                        ..._expenseStats.map(
                          (item) => DailyCategoryItem(item: item),
                        ),
                        ..._incomeStats.map(
                          (item) => DailyCategoryItem(item: item),
                        ),
                      ],
                    ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

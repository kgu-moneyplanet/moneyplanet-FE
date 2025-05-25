import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';
import '../viewModel/DailyAnalysisViewModel.dart';
import '../viewModel/MonthlyAnalysisViewModel.dart';
import '../viewModel/WeeklyAnalysisViewModel.dart';

class ChartSecondSection extends StatefulWidget {
  const ChartSecondSection({
    super.key,
    required this.jwtToken,
    required this.selectedView,
  });

  final String jwtToken;
  final String selectedView;

  @override
  State<ChartSecondSection> createState() => _ChartSecondSectionState();
}

class _ChartSecondSectionState extends State<ChartSecondSection> {
  final DailyAnalysisViewModel dailyViewModel = DailyAnalysisViewModel();
  final WeeklyAnalysisViewModel weeklyViewModel = WeeklyAnalysisViewModel();
  final MonthlyAnalysisViewModel monthlyViewModel = MonthlyAnalysisViewModel();

  @override
  void initState() {
    super.initState();
    _fetchDataIfNeeded();
    dailyViewModel.addListener(_onViewModelChanged);
    weeklyViewModel.addListener(_onViewModelChanged);
    monthlyViewModel.addListener(_onViewModelChanged);
  }

  @override
  void didUpdateWidget(covariant ChartSecondSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedView != oldWidget.selectedView) {
      _fetchDataIfNeeded();
    }
  }

  void _fetchDataIfNeeded() {
    final now = DateTime.now();

    if (widget.selectedView == 'Daily') {
      final statDate = now.toIso8601String().substring(0, 10);
      dailyViewModel.fetchDailyData(statDate);
    } else if (widget.selectedView == 'Weekly') {
      final weekOfYear = _getWeekNumber(now);
      weeklyViewModel.fetchWeeklyAnalysis(now.year, weekOfYear, widget.jwtToken);
    } else if (widget.selectedView == 'Monthly') {
      monthlyViewModel.fetchMonthlyAnalysis(now.year, now.month, widget.jwtToken);
    }
  }

  int _getWeekNumber(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysPassed = date.difference(firstDayOfYear).inDays;
    return ((daysPassed + firstDayOfYear.weekday) / 7).ceil();
  }

  @override
  void dispose() {
    dailyViewModel.removeListener(_onViewModelChanged);
    weeklyViewModel.removeListener(_onViewModelChanged);
    monthlyViewModel.removeListener(_onViewModelChanged);
    super.dispose();
  }

  void _onViewModelChanged() {
    if (!mounted) return;
    setState(() {});
    if (dailyViewModel.sumStat != null) {
      final stat = dailyViewModel.sumStat!;
     /* print('일일 데이터');
      print('총 수입: ${stat.totalIncome}, 총 지출: ${stat.totalExpense}');
      print('sumstat: ${dailyViewModel.dailyData!}');*/

    } else if (dailyViewModel.error != null) {
      print('일일 데이터 에러: ${dailyViewModel.error}');
    }
    if (weeklyViewModel.weeklyData != null) {
      final stat = weeklyViewModel.weeklyData!.sumStat;
      /*print('주간 데이터: ${weeklyViewModel.weeklyData!.year}년 ${weeklyViewModel.weeklyData!.week}주');
      print('총 수입: ${stat.totalIncome}, 총 지출: ${stat.totalExpense}');
      print('sumstat: ${weeklyViewModel.weeklyData!.sumStat}');*/
    } else if (weeklyViewModel.errorMessage != null) {
      print('주간 데이터 에러: ${weeklyViewModel.errorMessage}');
    }

    if (monthlyViewModel.monthlyData != null) {
      /*print('월간 데이터: ${monthlyViewModel.monthlyData!.year}년 ${monthlyViewModel.monthlyData!.month}월');
      print('sumStatList 개수: ${monthlyViewModel.monthlyData!.sumStatList.length}');

      print('총 수입: ${monthlyViewModel.monthlyData!.totalIncome}, 총 지출: ${monthlyViewModel.monthlyData!.totalExpense}');
      print('sumstat: ${monthlyViewModel.monthlyData!.sumStat}');*/
    } else if (monthlyViewModel.errorMessage != null) {
      print('월간 데이터 에러: ${monthlyViewModel.errorMessage}');
    }
  }

  @override
  Widget build(BuildContext context) {
    String incomeLabel = '';
    String expenseLabel = '';
    String incomeAmount = '0원';
    String expenseAmount = '0원';

    if (widget.selectedView == 'Daily') {
      incomeLabel = '오늘 수입';
      expenseLabel = '오늘 지출';

      if (dailyViewModel.isLoading) {
        incomeAmount = expenseAmount = '불러오는 중...';
      } else if (dailyViewModel.error != null) {
        incomeAmount = expenseAmount = '오류 발생';
      } else if (dailyViewModel.sumStat != null) {
        final stat = dailyViewModel.sumStat!;
        incomeAmount = '${_formatCurrency(stat.totalIncome)}원';
        expenseAmount = '${_formatCurrency(stat.totalExpense)}원';
      }
    } else if (widget.selectedView == 'Weekly') {
      incomeLabel = '이번주 수입';
      expenseLabel = '이번주 지출';

      if (weeklyViewModel.isLoading) {
        incomeAmount = expenseAmount = '불러오는 중...';
      } else if (weeklyViewModel.errorMessage != null) {
        incomeAmount = expenseAmount = '오류 발생';
      } else if (weeklyViewModel.weeklyData != null) {
        final stat = weeklyViewModel.weeklyData!.sumStat;
        incomeAmount = '${_formatCurrency(stat.totalIncome)}원';
        expenseAmount = '${_formatCurrency(stat.totalExpense)}원';
      }
    } else if (widget.selectedView == 'Monthly') {
      incomeLabel = '이번달 수입';
      expenseLabel = '이번달 지출';

      if (monthlyViewModel.isLoading) {
        incomeAmount = expenseAmount = '불러오는 중...';
      } else if (monthlyViewModel.errorMessage != null) {
        incomeAmount = expenseAmount = '오류 발생';
      } else if (monthlyViewModel.monthlyData != null) {
        final sumStat = monthlyViewModel.monthlyData!.sumStat;
        if (sumStat != null) {
          incomeAmount = '${_formatCurrency(sumStat.totalIncome)}원';
          expenseAmount = '${_formatCurrency(sumStat.totalExpense)}원';
        } else {
          incomeAmount = '${_formatCurrency(monthlyViewModel.monthlyData!.totalIncome)}원';
          expenseAmount = '${_formatCurrency(monthlyViewModel.monthlyData!.totalExpense)}원';
        }
      }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Container(
        width: double.infinity,
        height: 147,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            _buildInfoBlock(
              imagePath: 'assets/images/icons/arrow_square_upright.png',
              label: incomeLabel,
              amount: incomeAmount,
              labelColor: neutral_400,
              amountColor: Colors.black,
            ),
            Container(width: 1, height: 48, color: neutral_200),
            _buildInfoBlock(
              imagePath: 'assets/images/icons/arrow_square_downright.png',
              label: expenseLabel,
              amount: expenseAmount,
              labelColor: neutral_400,
              amountColor: secondary_200,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBlock({
    required String imagePath,
    required String label,
    required String amount,
    required Color labelColor,
    required Color amountColor,
  }) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath, width: 25.5, height: 25.5),
          const SizedBox(height: 9),
          Text(label, style: customTextStyle(fontFamily: Pretendard_Semibold_14, color: labelColor)),
          const SizedBox(height: 6),
          Text(amount, style: customTextStyle(fontFamily: Pretendard_Semibold_18, color: amountColor)),
        ],
      ),
    );
  }

  String _formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');
  }
}
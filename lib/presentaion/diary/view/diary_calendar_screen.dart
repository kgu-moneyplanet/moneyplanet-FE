import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_planet/global/theme/colors.dart';

import '../../../global/components/consumption_item.dart';
import '../model/diary_model.dart';

class DiaryCalendarScreen extends StatefulWidget {
  @override
  _DiaryCalendarScreenState createState() => _DiaryCalendarScreenState();
}

class _DiaryCalendarScreenState extends State<DiaryCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;
  PageController _pageController = PageController(initialPage: 0);

  final DateFormat _monthFormat = DateFormat('yyyy.MM');

  // 초기화되지 않아서 문제가 되었던 변수
  // late Map<DateTime, bool> transactionDates;
  Map<DateTime, bool>? transactionDates;

  @override
  void initState() {
    super.initState();
    _selectedDate = _focusedDay;
    _loadTransactionDates();
  }

  void _loadTransactionDates() {
    // 예시 데이터. 실제로는 서버나 로컬 DB에서 가져와야 함.
    setState(() {
      transactionDates = {
        DateTime(_focusedDay.year, _focusedDay.month, 5): true,
        DateTime(_focusedDay.year, _focusedDay.month, 12): true,
        DateTime(_focusedDay.year, _focusedDay.month, 25): true,
      };
    });
  }

  void _goToPreviousMonth() {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1, 1);
      _selectedDate = null;
      _loadTransactionDates();
    });
  }

  void _goToNextMonth() {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1, 1);
      _selectedDate = null;
      _loadTransactionDates();
    });
  }

  List<Widget> _buildDayHeaders() {
    final List<String> weekdays = ['일', '월', '화', '수', '목', '금', '토'];
    return weekdays
        .map(
          (day) => Center(
            child: Text(day, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        )
        .toList();
  }

  List<DateTime> _daysInMonth(DateTime month) {
    final first = DateTime(month.year, month.month, 1);
    final daysBefore = first.weekday % 7;
    final firstToDisplay = first.subtract(Duration(days: daysBefore));
    final last = DateTime(month.year, month.month + 1, 0);
    final daysAfter = 6 - (last.weekday % 7);
    final lastToDisplay = last.add(Duration(days: daysAfter));

    return List.generate(
      lastToDisplay.difference(firstToDisplay).inDays + 1,
      (index) => DateTime(
        firstToDisplay.year,
        firstToDisplay.month,
        firstToDisplay.day + index,
      ),
    );
  }

  Widget _buildDateGrid() {
    final days = _daysInMonth(_focusedDay);

    return SizedBox(
      height: 320, // 원하는 고정 높이
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        itemCount: days.length,
        itemBuilder: (context, index) {
          final day = days[index];
          final isSelected =
              _selectedDate != null &&
              day.year == _selectedDate!.year &&
              day.month == _selectedDate!.month &&
              day.day == _selectedDate!.day;
          final isToday =
              DateTime.now().year == day.year &&
              DateTime.now().month == day.month &&
              DateTime.now().day == day.day;

          final isWithinCurrentMonth = day.month == _focusedDay.month;
          final hasTransaction = transactionDates?[day] ?? false;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedDate = day;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color:
                    isSelected
                        ? Colors.blue
                        : isToday
                        ? Colors.blue[100]
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Text(
                      '${day.day}',
                      style: TextStyle(
                        color:
                            isWithinCurrentMonth ? Colors.black : Colors.grey,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                  if (hasTransaction)
                    Positioned(
                      bottom: 4,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildTransactionList() {
    final selectedList =
        DiaryMockData.where(
          (item) =>
              item.date.year == _selectedDate!.year &&
              item.date.month == _selectedDate!.month &&
              item.date.day == _selectedDate!.day,
        ).toList();

    if (selectedList.isEmpty) {
      return [
        Padding(padding: const EdgeInsets.all(16), child: Text('거래 내역이 없습니다.')),
      ];
    }

    return selectedList
        .map(
          (item) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ConsumptionItem(item: item),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral_900,
      appBar: AppBar(
        title: Text('캘린더', style: TextStyle(color: Colors.white)),
        backgroundColor: neutral_900,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            color: Colors.white
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: _goToPreviousMonth,
                    ),
                    Text(
                      _monthFormat.format(_focusedDay),
                      style: TextStyle(fontSize: 20),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: _goToNextMonth,
                    ),
                  ],
                ),
              ),
              GridView.count(
                crossAxisCount: 7,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: _buildDayHeaders(),
              ),
              _buildDateGrid(), // ← 고정 높이로 들어감
              if (_selectedDate != null) ..._buildTransactionList(),
            ],
          ),
        ),
      ),
    );
  }
}

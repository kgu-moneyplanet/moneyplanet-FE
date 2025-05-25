import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';

import '../../../global/components/consumption_item.dart';
import '../../../network/Daily/Response/TodayDiaryListResponseDTO.dart';
import '../../../network/TokenStorage.dart';

class DiaryCalendarScreen extends StatefulWidget {
  const DiaryCalendarScreen({super.key});

  @override
  _DiaryCalendarScreenState createState() => _DiaryCalendarScreenState();
}

class _DiaryCalendarScreenState extends State<DiaryCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;

  List<TodayDiaryListResponseDTO> todayDiaryList = [];
  bool isLoading = false;

  final DateFormat _monthFormat = DateFormat('yyyy.MM');

  @override
  void initState() {
    super.initState();
    _selectedDate = _focusedDay;
    _fetchDiaryListByDate(_focusedDay);
  }

  DateTime normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  void _goToPreviousMonth() {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1, 1);
      _selectedDate = null;
    });
  }

  void _goToNextMonth() {
    setState(() {
      _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1, 1);
      _selectedDate = null;
    });
  }

  List<Widget> _buildDayHeaders() {
    final List<String> weekdays = ['일', '월', '화', '수', '목', '금', '토'];
    return weekdays
        .map(
          (day) => Center(
            child: Text(
              day,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
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
      height: 320,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        itemCount: days.length,
        itemBuilder: (context, index) {
          final day = days[index];
          final normalizedDay = normalizeDate(day);
          final isSelected =
              _selectedDate != null &&
              normalizeDate(_selectedDate!) == normalizedDay;
          final isToday = normalizeDate(DateTime.now()) == normalizedDay;
          final isWithinCurrentMonth = day.month == _focusedDay.month;

          return GestureDetector(
            onTap: () {
              todayDiaryList.clear();
              setState(() {
                _selectedDate = day;
              });
              _fetchDiaryListByDate(day);
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
              child: Center(
                child: Text(
                  '${day.day}',
                  style: TextStyle(
                    color: isWithinCurrentMonth ? Colors.black : Colors.grey,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildTransactionList() {
    if (_selectedDate == null) return [];

    if (isLoading) {
      return [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: CircularProgressIndicator()),
        ),
      ];
    }

    if (todayDiaryList.isEmpty) {
      return [
        const Padding(padding: EdgeInsets.all(16), child: Text('거래 내역이 없습니다.')),
      ];
    }

    return todayDiaryList
        .map(
          (item) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GestureDetector(
              onTap: () => _showDiaryDetailModal(item),
              child: ConsumptionItem(item: item),
            ),
          ),
        )
        .toList();
  }

  Future<void> _fetchDiaryListByDate(DateTime selectedDate) async {
    try {
      setState(() => isLoading = true);
      final token = await TokenStorage.getToken();
      final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      final url = Uri.parse(
        'https://money-planet.store/api/v1/tx/list/$formattedDate',
      );

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      final decodedBody = utf8.decode(response.bodyBytes);

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(decodedBody);
        final dataList = json['data'];

        if (dataList != null && dataList is List) {
          final parsedList =
              dataList
                  .map((e) => TodayDiaryListResponseDTO.fromJson(e))
                  .toList();

          setState(() {
            todayDiaryList = parsedList;
          });
        } else {
          setState(() {
            todayDiaryList = [];
          });
        }
      }
    } catch (e) {
      print('🔥 [Exception] $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _showDiaryDetailModal(TodayDiaryListResponseDTO item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              runSpacing: 12,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    color: Colors.grey[300],
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  '상세 내역',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                Row(
                  children: [
                    Text('🛍️ 타입: ', style: Pretendard_Semibold_16),
                    const SizedBox(width: 10),
                    Text(item.type == 'EXPENSE' ? '지출' : '수입'),
                  ],
                ),
                SizedBox(height: 8),

                Row(
                  children: [
                    Text('📌 내용: ', style: Pretendard_Semibold_16),
                    const SizedBox(width: 10),
                    Text(item.content),
                  ],
                ),
                SizedBox(height: 8),

                Row(
                  children: [
                    Text('💸 금액:', style: Pretendard_Semibold_16),
                    const SizedBox(width: 10),
                    Text(
                      '${NumberFormat('#,###').format(item.amount)}원',
                    ),
                  ],
                ),

                SizedBox(height: 8),

                Row(
                  children: [
                    Text('👍 소비방법:', style: Pretendard_Semibold_16),
                    const SizedBox(width: 10),
                    Text(_mapAssetToMethod(item.method)),
                  ],
                ),

                SizedBox(height: 8),

                Row(
                  children: [
                    Text('📁 카테고리:', style: Pretendard_Semibold_16),
                    const SizedBox(width: 10),
                    Text(
                      getCategoryNameById(item.categoryId),
                    ),
                  ],
                ),

                SizedBox(height: 8),

                if (item.memo.isNotEmpty) ...[
                  Row(
                    children: [
                      Text('📝 메모:', style: Pretendard_Semibold_16),
                      const SizedBox(width: 10),
                      Text(item.memo,),
                    ],
                  ),
                ],

                const Divider(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '🧠 소비 리포트',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: [
                        Text('ABC 타입 :', style: Pretendard_Semibold_16),
                        Expanded(child: Text(item.reportResponseDto?.abc ?? '없음', softWrap: true,)),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 10,
                      children: [
                        Text('피드백:', style: Pretendard_Semibold_16),
                        Expanded(child: Text(item.reportResponseDto?.feedback ?? '없음', softWrap: true)),
                      ],
                    ),

                    SizedBox(height: 30,)
                  ],
                ),

              ],
            ),
          ),
        );
      },
    );
  }

  String _mapAssetToMethod(String input) {
    switch (input) {
      case 'CASH':
        return '현금';
      case 'CHECK':
        return '체크카드';
      case 'CREDIT':
        return '신용카드';
      case 'BANK_TRANSFER':
        return '은행계좌';
      default:
        return 'UNKNOWN'; // 혹시나 예외처리를 위해
    }
  }

  String getCategoryNameById(int categoryId) {
    final categoryNameMap = {
      1: '식비',
      2: '교통/차량',
      3: '문화생활',
      4: '마트/편의점',
      5: '패션/미용',
      6: '생활용품',
      7: '주거/통신',
      8: '건강',
      9: '교육',
      10: '경조사/회비',
      11: '부모님',
      12: '저축성 지출',
      13: '세금',
      14: '반려동물',
      15: '기타',
      16: '월급',
    };
    return categoryNameMap[categoryId] ?? '기타';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral_900,
      appBar: AppBar(
        title: const Text('캘린더', style: TextStyle(color: Colors.white)),
        backgroundColor: neutral_900,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: _goToPreviousMonth,
                    ),
                    Text(
                      _monthFormat.format(_focusedDay),
                      style: const TextStyle(fontSize: 20),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed: _goToNextMonth,
                    ),
                  ],
                ),
              ),
              GridView.count(
                crossAxisCount: 7,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: _buildDayHeaders(),
              ),
              _buildDateGrid(),
              if (_selectedDate != null) ..._buildTransactionList(),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

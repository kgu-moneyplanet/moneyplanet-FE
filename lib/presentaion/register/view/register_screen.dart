import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';
import 'package:money_planet/network/TokenStorage.dart';

import '../../../network/Daily/Request/ABCRequestDTO.dart';
import '../../../network/Daily/Response/ABCResponseDTO.dart';

class RegisterScreen extends StatefulWidget {
  final bool isIncome;

  const RegisterScreen({super.key, required this.isIncome});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isAnalyzing = false;
  late bool isIncome;
  bool showAnalysisResult = false;

  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _amountController = TextEditingController();
  final _categoryController = TextEditingController();
  final _assetController = TextEditingController();
  final _noteController = TextEditingController();
  final _memoController = TextEditingController();

  String selectedType = '';

  String reasonText = '';
  String feedbackText = '';

  @override
  void initState() {
    super.initState();
    isIncome = widget.isIncome;
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _amountController.dispose();
    _categoryController.dispose();
    _assetController.dispose();
    _noteController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  void _selectDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null) {
      final selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (selectedTime != null) {
        final dateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );
        _dateController.text =
            "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} ";
        _timeController.text =
            "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}";
      }
    }
  }

  void _showCategoryModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        final categories = [
          '식비',
          '교통/차량',
          '문화생활',
          '마트/편의점',
          '패션/미용',
          '생활용품',
          '주거/통신',
          '건강',
          '교육',
          '경조사/회비',
          '부모님',
          '저축성 지출',
          '세금',
          '반려동물',
          '월급',
          '기타',
        ];
        return Container(
          padding: const EdgeInsets.only(
            top: 20,
            right: 20,
            bottom: 70,
            left: 20,
          ),
          width: double.infinity,
          child: Wrap(
            spacing: 10,
            runSpacing: 10,
            children:
                categories.map((category) {
                  return ChoiceChip(
                    label: Text(category),
                    selected: _categoryController.text == category,
                    onSelected: (_) {
                      setState(() {
                        _categoryController.text = category;
                      });
                      Navigator.pop(context);
                    },
                    selectedColor: primary_050,
                    labelStyle: const TextStyle(fontSize: 16),
                  );
                }).toList(),
          ),
        );
      },
    );
  }

  void _showAssetModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        final assets = ['현금', '체크카드', '신용카드', '은행계좌'];
        return Container(
          padding: const EdgeInsets.only(
            top: 20,
            right: 20,
            bottom: 70,
            left: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:
                assets.map((asset) {
                  return ListTile(
                    title: Text(asset),
                    onTap: () {
                      setState(() {
                        _assetController.text = asset;
                      });
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
          ),
        );
      },
    );
  }

  Future<void> parseClipboardAndFillFields() async {
    final clipboardData = await Clipboard.getData('text/plain');
    final text = clipboardData?.text ?? '';
    final lines = text.split('\n');

    String? dateStr;
    String? timeStr;
    String? amountStr;
    String? contentStr;

    final dateRegex = RegExp(r'(\d{2})/(\d{2})'); // MM/DD
    final timeRegex = RegExp(r'(\d{2}):(\d{2})'); // HH:mm
    final amountRegex = RegExp(r'([\d,]+)원'); // 금액
    final contentRegex = RegExp(r'[^\d]+사용');

    for (final line in lines) {
      if (dateRegex.hasMatch(line)) {
        final match = dateRegex.firstMatch(line)!;
        final month = match.group(1)!;
        final day = match.group(2)!;
        final year = DateTime.now().year;
        final formattedDate = DateFormat(
          'yyyy-MM-dd',
        ).format(DateTime(year, int.parse(month), int.parse(day)));
        dateStr = formattedDate;
      }

      if (timeRegex.hasMatch(line)) {
        timeStr = timeRegex.firstMatch(line)!.group(0)!;
      }

      if (amountRegex.hasMatch(line)) {
        amountStr = amountRegex.firstMatch(line)!.group(1)!.replaceAll(',', '');
      }

      if (contentRegex.hasMatch(line)) {
        contentStr = contentRegex.firstMatch(line)!.group(0)!;
      }
    }

    // 여기서 이 값을 각 TextEditingController 등에 넣어주면 돼
    print('날짜: $dateStr');
    print('시간: $timeStr');
    print('금액: $amountStr');
    print('내용: $contentStr');

    // 예시 - 실제로 컨트롤러에 적용
    _dateController.text = dateStr ?? '';
    _timeController.text = timeStr ?? '';
    _amountController.text = amountStr ?? '';
    _memoController.text = contentStr ?? '';
    _assetController.text = contentStr!.isEmpty ? '' : '체크카드';
  }

  Future<void> analyzeTransactionData() async {
    setState(() => isAnalyzing = true); // 시작할 때 true

    try {
      final token = await TokenStorage.getToken();

      final dto = ABCRequestDTO(
        txDate: _dateController.text.trim(),
        amount: priceToInt(_amountController.text),
        categoryId: getCategoryIdPath(_categoryController.text),
        content: _categoryController.text,
        memo: _memoController.text,
      );

      final uri = Uri.parse('https://money-planet.store/api/v1/tx/decision');

      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(dto.toJson()),
      );

      final decodedBody = utf8.decode(response.bodyBytes);

      print('요청 본문: ${jsonEncode(dto.toJson())}');
      print('응답 코드: ${response.statusCode}');
      print('응답 본문: $decodedBody');

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(decodedBody);
        final abcResponse = ABCResponseDTO.fromJson(json);

        final result = abcResponse.data;

        setState(() {
          showAnalysisResult = true;
          reasonText = result.reason;
          feedbackText = result.feedback;
          selectedType = result.abc;
        });
      } else {
        print('서버 오류 발생: ${response.statusCode}');
        print('서버 응답: $decodedBody');
      }
    } catch (e) {
      print('네트워크 오류: $e');
    } finally {
      setState(() => isAnalyzing = false); // 끝났을 때 false
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SafeArea(
              top: false,
              child: Column(
                children: [
                  _buildHeader(),
                  const SizedBox(height: 30),
                  _buildToggleTab(),
                  const SizedBox(height: 30),
                  if (!isIncome) ...[
                    ElevatedButton(
                      onPressed: () => parseClipboardAndFillFields(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondary_200,
                        // 배경 색상
                        foregroundColor: Colors.white,
                        // 텍스트 색상
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // 둥근 모서리
                        ),
                        elevation: 4,
                        // 그림자 깊이
                        shadowColor: secondary_300, // 그림자 색상
                      ),
                      child: const Text('📋 붙여넣기', style: Pretendard_Semibold_16),
                    ),
                    const SizedBox(height: 30),
                  ],

                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          '날짜',
                          _dateController,
                          readOnly: true,
                          onTap: _selectDate,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildTextField(
                          '시간',
                          _timeController,
                          readOnly: true,
                          onTap: () async {
                            final selectedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (selectedTime != null) {
                              _timeController.text =
                              "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}";
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  _buildTextField(
                    '금액',
                    _amountController,
                    keyboardType: TextInputType.number,
                    suffixText: '원',
                    onChanged: (value) {
                      var numericString = value.replaceAll(RegExp(r'[^0-9]'), '');
                      if (numericString.isEmpty) {
                        _amountController.clear();
                        return;
                      }
                      var intValue = int.parse(numericString);
                      if (intValue > 10000000) {
                        _amountController.text = "10,000,000";
                        intValue = 10000000;
                        return;
                      }
                      var formatted = NumberFormat.decimalPattern().format(
                        intValue,
                      );
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _amountController.value = TextEditingValue(
                          text: formatted,
                          selection: TextSelection.collapsed(
                            offset: formatted.length,
                          ),
                        );
                      });
                    },
                  ),
                  _buildTextField(
                    '분류',
                    _categoryController,
                    readOnly: true,
                    onTap: _showCategoryModal,
                  ),

                  _buildTextField(
                    '자산',
                    _assetController,
                    readOnly: true,
                    onTap: _showAssetModal,
                  ),
                  _buildTextField('내용', _noteController),

                  SizedBox(height: 20),

                  Divider(),

                  SizedBox(height: 20),

                  _buildTextField('메모', _memoController),
                  if (!isIncome) ...[
                    const SizedBox(height: 10),
                    _buildTypeSelector(),
                    const SizedBox(height: 20),
                    if (!showAnalysisResult) ...[
                      ElevatedButton(
                        onPressed: () async {
                          await analyzeTransactionData();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[100],
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'AI 분석하기',
                          style: TextStyle(
                            color: primary_400,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    if (showAnalysisResult) ...[
                      const SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          border: Border.all(color: Colors.blue[200]!),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              'AI 분석결과',
                              style: TextStyle(
                                color: primary_400,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 36,
                                    backgroundColor: primary_400,
                                    child: Image.asset(
                                      getCategoryImagePath(
                                        _categoryController.text,
                                      ),
                                      width: 36,
                                      height: 36,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          reasonText,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(height: 6),
                                        Text(
                                          feedbackText,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  selectedType = 'C';
                                  showAnalysisResult = false;
                                });
                              },
                              label: const Text('확인'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                  horizontal: 100,
                                ),
                                backgroundColor: primary_400,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      // 저장 로직 처리
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary_400,
                      minimumSize: const Size.fromHeight(56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      '저장하기',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
        if (isAnalyzing)
          Positioned.fill(
            child: Container(
              color: neutral_900,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/rocket1.png', width: 300),
                  const SizedBox(height: 24),
                  const Text('AI가 분석하고 있습니다.', style: TextStyle(color: Colors.white, fontSize: 18)),
                  const SizedBox(height: 8),
                  const Text('로켓발사 준비 중...', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('닫기', style: Pretendard_Semibold_14),
              SizedBox(width: 4),
              Icon(Icons.close),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isIncome ? '수입' : '지출',
              style: customTextStyle(fontFamily: Pretendard_Semibold_20),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildToggleTab() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[400]!),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(child: _buildTabButton('수입', true)),
          const SizedBox(width: 10),
          Expanded(child: _buildTabButton('지출', false)),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, bool incomeTab) {
    final isSelected = isIncome == incomeTab;
    return GestureDetector(
      onTap: () => setState(() => isIncome = incomeTab),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? primary_400 : Colors.transparent,
          borderRadius:
              incomeTab
                  ? const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  )
                  : const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : primary_400,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool readOnly = false,
    VoidCallback? onTap,
    TextInputType? keyboardType,
    String? suffixText,
    ValueChanged<String>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Pretendard_Semibold_18),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          readOnly: readOnly,
          keyboardType: keyboardType,
          onTap: onTap,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: primary_400, width: 2),
            ),
            suffixText: suffixText,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildTypeSelector() {
    final types = ['A', 'B', 'C'];
    return Row(
      children:
          types.map((type) {
            final isSelected = selectedType == type;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: OutlinedButton(
                  onPressed: null,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      width: isSelected ? 3 : 1,
                      color: isSelected ? primary_400 : Colors.grey,
                    ),
                  ),
                  child: Text(type, style: Pretendard_Semibold_20),
                ),
              ),
            );
          }).toList(),
    );
  }

  String getCategoryImagePath(String category) {
    final imageMap = {
      '식비': 'assets/images/icons/category_food.png',
      '교통/차량': 'assets/images/icons/category_transport.png',
      '문화생활': 'assets/images/icons/category_entertainment.png',
      '마트/편의점': 'assets/images/icons/category_mart.png',
      '패션/미용': 'assets/images/icons/category_fashion.png',
      '생활용품': 'assets/images/icons/category_mart.png',
      '주거/통신': 'assets/images/icons/category_home.png',
      '건강': 'assets/images/icons/category_health.png',
      '교육': 'assets/images/icons/category_mart.png',
      '경조사/회비': 'assets/images/icons/category_event.png',
      '부모님': 'assets/images/icons/category_parents.png',
      '저축성 지출': 'assets/images/icons/category_saving.png',
      '세금': 'assets/images/icons/category_tax.png',
      '반려동물': 'assets/images/icons/category_pet.png',
      '기타': 'assets/images/icons/category_coffee.png',
      '월급': 'assets/images/icons/category_saving.png',
    };

    // 기본 이미지 지정
    return imageMap[category] ?? 'assets/images/icons/category_coffee.png';
  }

  int getCategoryIdPath(String category) {
    final categoryIdMap = {
      '식비': 1,
      '교통/차량': 2,
      '문화생활': 3,
      '마트/편의점': 4,
      '패션/미용': 5,
      '생활용품': 6,
      '주거/통신': 7,
      '건강': 8,
      '교육': 9,
      '경조사/회비': 10,
      '부모님': 11,
      '저축성 지출': 12,
      '세금': 13,
      '반려동물': 14,
      '기타': 15,
      '월급': 16,
    };

    return categoryIdMap[category] ?? 15;
  }

  int priceToInt(String price) {
    var result = price.replaceAll(',', '');
    return int.parse(result);
  }
}

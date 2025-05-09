import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';

class RegisterScreen extends StatefulWidget {
  final bool isIncome;

  const RegisterScreen({super.key, required this.isIncome});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late bool isIncome;
  bool showAnalysisResult = false;

  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _amountController = TextEditingController();
  final _categoryController = TextEditingController();
  final _assetController = TextEditingController();
  final _noteController = TextEditingController();

  String selectedType = 'A';

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
            "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} "
            "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
        _timeController.text =
            "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                  var formatted = NumberFormat.decimalPattern().format(intValue);
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _amountController.value = TextEditingValue(
                      text: formatted,
                      selection: TextSelection.collapsed(offset: formatted.length),
                    );
                  });
                },
              ),
              _buildTextField('분류', _categoryController),
              _buildTextField('자산', _assetController),
              _buildTextField('내용', _noteController),
              if (!isIncome) ...[
                const SizedBox(height: 10),
                _buildTypeSelector(),
                const SizedBox(height: 20),
                if (!showAnalysisResult) ...[
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showAnalysisResult = true;
                      });
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
                                backgroundColor: primary_400.withOpacity(0.2),
                                child: Icon(
                                  Icons.ramen_dining,
                                  size: 36,
                                  color: primary_400,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      'A-필수 소비',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      'Lorem ipsum dolor sit amet consectetur. Feugiat sapien eget lectus integer nulla rhoncus iaculis.',
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
                              showAnalysisResult = false;
                            });
                          },
                          icon: const Icon(Icons.edit, size: 18),
                          label: const Text('수정하기'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 24,
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
                  onPressed: () => setState(() => selectedType = type),
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
}

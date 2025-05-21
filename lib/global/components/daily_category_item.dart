import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';
import 'package:money_planet/network/Daily/Response/DailyCategoryResponseDTO.dart';

class DailyCategoryItem extends StatelessWidget {
  final CategoryStatDtoList item;

  DailyCategoryItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _getCategoryColor(item.categoryName),
            ),
            padding: const EdgeInsets.all(6),
            child: Image.asset(
              _getCategoryIconPath(item.categoryName),
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 16),
          // 텍스트
          Expanded(
            child: Text(
              item.categoryName,
              style: customTextStyle(
                fontFamily: Pretendard_Semibold_14,
                color: neutral_1100,
              ),
            ),
          ),

          Text(
              item.categoryName == '월급' ? "+ ${_formatCurrency(item.amount)} 원" : "- ${_formatCurrency(item.amount)} 원",
            style: customTextStyle(
              fontFamily: Pretendard_Semibold_16,
              color: item.categoryName == '월급' ? Colors.green : neutral_1100,
            ),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    );
  }

  String _getCategoryIconPath(String category) {
    switch (category) {
      case '식비':
        return 'assets/images/icons/category_food.png';
      case '교통/차량':
        return 'assets/images/icons/category_car.png';
      case '문화생활':
        return 'assets/images/icons/category_culture.png';
      case '마트/편의점':
        return 'assets/images/icons/category_mart.png';
      case '패션/미용':
        return 'assets/images/icons/category_fashion.png';
      case '생활용품':
        return 'assets/images/icons/category_life.png';
      case '주거/통신':
        return 'assets/images/icons/category_home.png';
      case '건강':
        return 'assets/images/icons/category_health.png';
      case '교육':
        return 'assets/images/icons/category_education.png';
      case '경조사/회비':
        return 'assets/images/icons/category_event.png';
      case '부모님':
        return 'assets/images/icons/category_home.png';
      case '저축성 지출':
        return 'assets/images/icons/category_saving.png';
      case '세금':
        return 'assets/images/icons/category_tax.png';
      case '반려동물':
        return 'assets/images/icons/category_pet.png';
      case '기타':
        return 'assets/images/icons/category_coffee.png';
      default:
        return 'assets/images/icons/category_saving.png';
    }
  }

  Color _getCategoryColor(String category) {
    // 카테고리 색상 지정, 없으면 기본값
    return primary_050;
  }

  final Map<int, String> categoryNames = {
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
}

import 'package:flutter/material.dart';
import 'package:money_planet/global/theme/colors.dart';
import 'package:money_planet/global/theme/textStyles.dart';
import 'package:money_planet/presentaion/diary/model/diary_model.dart';

class ConsumptionItem extends StatelessWidget {
  final DiaryModel item;

  const ConsumptionItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // 아이콘 이미지 (카테고리별로 자동 변경)
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              /// TODO: - 여기가 ABC따라서 아이콘 배경색 바꾸는 곳, 아이콘 새로 다운 받아서 구현해야함
              color: secondary_200,
            ),
            padding: const EdgeInsets.all(6),
            child: Image.asset(
              _getCategoryIconPath(item.category),
              fit: BoxFit.fill,
            ),
          ),

          const SizedBox(width: 16),

          // 텍스트 영역
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.description,
                  style: customTextStyle(
                    fontFamily: Pretendard_Semibold_14,
                    color: neutral_1100,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.category,
                  style: customTextStyle(
                    fontFamily: Pretendard_Medium_14,
                    color: neutral_300,
                  ),
                ),
              ],
            ),
          ),

          // 금액
          Text(
            "${item.isIncome ? '+ ' : '- '}${_formatCurrency(item.amount)}원",
            style: customTextStyle(
              fontFamily: Pretendard_Semibold_16,
              color: item.isIncome ? Colors.green : neutral_1100,
            ),
          ),
        ],
      ),
    );
  }

  // 금액 천 단위 콤마 처리
  String _formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
    );
  }

  // 카테고리에 따른 아이콘 경로 반환
  String _getCategoryIconPath(String category) {
    switch (category) {
      case '식비':
        return 'lib/global/assets/images/icons/category_food.png';
      case '교통/차량':
        return 'lib/global/assets/images/icons/category_car.png';
      // case '문화생활':
      //   return 'lib/global/assets/images/icons/category_culture.png';
      // case '마트/편의점':
      //   return 'lib/global/assets/images/icons/category_mart.png';
      // case '패션/미용':
      //   return 'lib/global/assets/images/icons/category_fashion.png';
      case '생활용품':
        return 'lib/global/assets/images/icons/category_life.png';
      // case '주거/통신':
      //   return 'lib/global/assets/images/icons/category_home.png';
      case '건강':
        return 'lib/global/assets/images/icons/category_health.png';
      // case '교육':
      //   return 'lib/global/assets/images/icons/category_education.png';
      // case '경조사/회비':
      //   return 'lib/global/assets/images/icons/category_event.png';
      // case '부모님':
      //   return 'lib/global/assets/images/icons/category_parents.png';
      // case '저축성 지출':
      //   return 'lib/global/assets/images/icons/category_saving.png';
      // case '세금':
      //   return 'lib/global/assets/images/icons/category_tax.png';
      // case '반려동물':
      //   return 'lib/global/assets/images/icons/category_pet.png';
      // case '기타':
      //   return 'lib/global/assets/images/icons/category_etc.png';
      default:
        return 'lib/global/assets/images/icons/category_coffee.png';
    }
  }
}

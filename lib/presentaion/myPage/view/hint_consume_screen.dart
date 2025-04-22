import 'package:flutter/material.dart';
import '../../../global/theme/colors.dart';


class HintConsumeScreen extends StatelessWidget {
  const HintConsumeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildCard(
            title: '행성타입 - 수성',
            description: '분석적 소비형 · INTJ, INTP\n충동적인 소비를 피하고 데이터를 기반으로 신중한 소비를 추구...',
            iconAsset: 'assets/images/mercury.png',
          ),
          _buildCard(
            title: '행성타입 - 금성',
            description: '감각적인 감정적 소비형 · ESFP, ESFJ\n감각적인 만족을 추구하며, 자신에게 즐거움을 주는 상품에 소비...',
            iconAsset: 'assets/images/venus.png',
          ),
          _buildCard(
            title: '행성타입 - 지구',
            description: '계획적인 소비형 · ISTJ, ESTJ\n철저히 계획을 세우고, 필요와 여유를 판단하여 소비를 실천...',
            iconAsset: 'assets/images/earth.png',
          ),
        ],
      ),
    );
  }

  Widget _buildCard({required String title, required String description, required String iconAsset}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Image.asset(iconAsset, width: 60, height: 60),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 8),
                  Text(description, style: TextStyle(color: Colors.grey[700])),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text('자세히보기 >', style: TextStyle(color: Colors.blue)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
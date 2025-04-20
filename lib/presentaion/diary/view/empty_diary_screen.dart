import 'package:flutter/material.dart';

import '../../../global/theme/textStyles.dart';

class EmptyDiaryScreen extends StatelessWidget {
  const EmptyDiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            color: Colors.white,
          ),
          height: 500,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // TODO: - 본인 행성 아이콘으로 맞추기
                Image.asset(
                  "lib/global/assets/images/planet_icon/planet3.png",
                  width: 300,
                  height: 300,
                  fit: BoxFit.fill,

                ),

                Container(
                  width: double.infinity,
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Text(
                    "이 달의 내역이 없습니다.",
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

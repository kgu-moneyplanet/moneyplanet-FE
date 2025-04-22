import 'package:flutter/material.dart';

class HintABCScreen extends StatelessWidget {
  const HintABCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'ABC란?\n\nA: 꼭 필요한 지출\nB: 반드시까지는 아니지만 필요한 지출\nC: 없어도 되는 지출',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
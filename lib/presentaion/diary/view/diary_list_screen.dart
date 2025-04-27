import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../global/components/consumption_item.dart';
import '../model/diary_model.dart';

class DiaryListScreen extends StatelessWidget {
  final Map<String, List<DiaryModel>> groupedData;

  const DiaryListScreen({super.key, required this.groupedData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children:
            groupedData.entries.map((entry) {
              final date = DateTime.parse(entry.key);
              final dayText = DateFormat(
                'd일 EEEE',
                'ko',
              ).format(date);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dayText ==
                        DateFormat(
                          'd일 EEEE',
                          'ko',
                        ).format(DateTime.now())
                        ? "${date.day}일 오늘"
                        : dayText,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 10),
                  ...entry.value.map(
                        (item) => ConsumptionItem(item: item),
                  ),
                  const SizedBox(height: 20),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

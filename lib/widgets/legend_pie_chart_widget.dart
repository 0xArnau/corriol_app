import 'package:flutter/material.dart';

class LegendPieChartWidget extends StatelessWidget {
  const LegendPieChartWidget(
      {super.key, required this.color, required this.text});

  final String text;
  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      CircleAvatar(
        backgroundColor: color,
      ),
      const SizedBox(width: 5),
      Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    ]);
  }
}

import 'package:flutter/material.dart';

class RowDadosWidget extends StatelessWidget {
  final String title, subtitle;
  const RowDadosWidget(
      {super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(
          subtitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';

class SummaryLine extends StatelessWidget {
  final dynamic summary;
  const SummaryLine({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Title(
            color: Colors.black,
            child: const Text(
              "Descrição",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        Text(
          summary,
          textAlign: TextAlign.justify,
        )
      ],
    );
  }
}

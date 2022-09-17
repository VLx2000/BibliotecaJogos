import 'package:flutter/material.dart';

class PlatformsLine extends StatelessWidget {
  final dynamic platforms;
  const PlatformsLine({super.key, required this.platforms});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Title(
                color: Colors.black,
                child: const Text(
                  "Plataformas",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            if (platforms != null)
              for (var platform in platforms) Text("- ${platform['name']}"),
          ],
        ),
      ],
    );
  }
}

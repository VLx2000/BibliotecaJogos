import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GenreColumn extends StatelessWidget {
  final dynamic genres;
  const GenreColumn({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Title(
            color: Colors.black,
            child: Text(
              AppLocalizations.of(context)!.genres,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        if (genres != null)
          for (var genre in genres!) Text("- ${genre['name']}"),
      ],
    );
  }
}

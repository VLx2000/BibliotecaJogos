import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RatingColumn extends StatelessWidget {
  final dynamic rating;
  const RatingColumn({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    double ratingNumber =
        rating == null ? 0 : double.parse(rating.toStringAsPrecision(3));
    Color cor = Colors.black;

    if (ratingNumber == 0) {
      cor = Colors.grey;
    } else if (ratingNumber >= 70) {
      cor = Colors.green;
    } else if (ratingNumber > 50 && ratingNumber < 70) {
      cor = Colors.orange;
    } else if (ratingNumber <= 50) {
      cor = Colors.red;
    }

    return Column(
      children: [
        Text(
          "$ratingNumber",
          style: TextStyle(
            color: cor,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          AppLocalizations.of(context)!.rating,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

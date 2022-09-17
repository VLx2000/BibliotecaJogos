import 'package:flutter/material.dart';

class PlaylistButton extends StatelessWidget {
  final String playlist;
  const PlaylistButton({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Text(
        playlist,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../models/character.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const CharacterCard({
    super.key,
    required this.character,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          Expanded(
            child: Image.network(character.image, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(character.name, textAlign: TextAlign.center),
          ),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: IconButton(
              key: ValueKey(isFavorite),
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: onFavoriteToggle,
            ),
          ),
        ],
      ),
    );
  }
}

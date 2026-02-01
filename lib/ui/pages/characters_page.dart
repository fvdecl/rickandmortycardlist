import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/app_state.dart';
import '../widgets/character_card.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return FutureBuilder(
      future: appState.characters.isEmpty
          ? appState.loadCharacters()
          : null,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (appState.characters.isEmpty) {
          return const Center(
            child: Text('Нет данных'),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 3 / 4,
          ),
          itemCount: appState.characters.length,
          itemBuilder: (context, index) {
            final character = appState.characters[index];
            final isFavorite = appState.isFavorite(character.id);

            return CharacterCard(
              character: character,
              isFavorite: isFavorite,
              onFavoriteToggle: () =>
                  appState.toggleFavorite(character.id),
            );
          },
        );
      },
    );
  }
}

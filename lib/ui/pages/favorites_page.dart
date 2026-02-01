import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/app_state.dart';
import '../../models/character.dart';
import '../widgets/character_card.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  bool sortAscending = true;

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    final List<Character> favoriteCharacters = appState.characters
        .where((c) => appState.favorites.contains(c.id))
        .toList();

    if (favoriteCharacters.isEmpty) {
      return const Center(
        child: Text('No favorites yet'),
      );
    }

    favoriteCharacters.sort(
      (a, b) => sortAscending
          ? a.name.compareTo(b.name)
          : b.name.compareTo(a.name),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        actions: [
          IconButton(
            icon: Icon(
              sortAscending ? Icons.sort_by_alpha : Icons.sort,
            ),
            onPressed: () {
              setState(() {
                sortAscending = !sortAscending;
              });
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 3 / 4,
        ),
        itemCount: favoriteCharacters.length,
        itemBuilder: (context, index) {
          final character = favoriteCharacters[index];

          return CharacterCard(
            character: character,
            isFavorite: true,
            onFavoriteToggle: () =>
                appState.toggleFavorite(character.id),
          );
        },
      ),
    );
  }
}

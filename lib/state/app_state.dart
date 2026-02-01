import 'package:flutter/material.dart';
import '../models/character.dart';
import '../services/api_service.dart';
import '../services/favorites_db.dart';

class AppState extends ChangeNotifier {
  final ApiService api;

  AppState(this.api) {
    _loadFavorites();
  }

  List<Character> characters = [];
  Set<int> favorites = {};
  bool isDarkTheme = false;

  Future<void> loadCharacters() async {
    characters = await api.fetchCharacters();
    notifyListeners();
  }

  Future<void> _loadFavorites() async {
    favorites = await FavoritesDB.getFavorites();
    notifyListeners();
  }

  Future<void> toggleFavorite(int id) async {
    if (favorites.contains(id)) {
      favorites.remove(id);
      await FavoritesDB.remove(id);
    } else {
      favorites.add(id);
      await FavoritesDB.add(id);
    }
    notifyListeners();
  }

  bool isFavorite(int id) => favorites.contains(id);

  void toggleTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }
}

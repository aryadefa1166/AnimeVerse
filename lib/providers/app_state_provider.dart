import 'package:flutter/cupertino.dart';
import '../models/anime.dart';

class AppStateProvider extends ChangeNotifier {
  // data
  List<Anime> _favorites = [];

  // getter
  List<Anime> get favorites => _favorites;

  // helper
  bool isFavorite(String id) {
    return _favorites.any((anime) => anime.id == id);
  }

  void toggleFavorite(Anime anime) {
    if (isFavorite(anime.id)) {
      removeFavorite(anime.id);
    } else {
      addFavorite(anime);
    }
  }

  void addFavorite(Anime anime) {
    if (!isFavorite(anime.id)) {
      _favorites.add(anime);
      notifyListeners();
    }
  }

  void removeFavorite(String id) {
    _favorites.removeWhere((anime) => anime.id == id);
    notifyListeners();
  }
}
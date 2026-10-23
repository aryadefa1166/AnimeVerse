import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_scaffold.dart';
import '../providers/app_state_provider.dart';
import '../widgets/favorite_anime_card.dart';
import '../widgets/search_field.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    // Mengambil state query pencarian favorit dari provider
    _searchController = TextEditingController(
      text: context.read<AppStateProvider>().favoriteSearchQuery,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Sambungkan Provider
    final favoriteProvider = context.watch<AppStateProvider>();
    final favorites = favoriteProvider.getFilteredFavorites();

    return AppScaffold(
      appBar: AppBar(
        title: Text(
          "Favorite Anime",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: screenWidth * 0.06,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar untuk Favorit
          SearchField(
            controller: _searchController,
            hintText: 'Search favorites',
            onChanged: (value) {
              favoriteProvider.setFavoriteSearchQuery(value);
            },
            showClear: favoriteProvider.favoriteSearchQuery.isNotEmpty,
            onClear: () {
              _searchController.clear();
              favoriteProvider.setFavoriteSearchQuery('');
            },
          ),

          SizedBox(height: screenHeight * 0.01),

          // Favorite Anime List & Empty States
          Expanded(
            child: favorites.isEmpty
                ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.favorite_border,
                    size: 32,
                    color: Colors.white70,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    favoriteProvider.favorites.isEmpty
                        ? 'Belum ada anime favorit'
                        : 'Anime tidak ditemukan',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final favoriteAnime = favorites[index];
                return FavoriteAnimeCard(
                  id: favoriteAnime.id,
                  title: favoriteAnime.title,
                  genre: favoriteAnime.genre,
                  rating: favoriteAnime.rating,
                  imagePath: favoriteAnime.imagePath,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
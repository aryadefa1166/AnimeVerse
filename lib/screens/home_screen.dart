import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state_provider.dart';
import '../widgets/app_scaffold.dart';
import '../widgets/genre_list.dart';
import '../widgets/anime_view.dart';
import '../widgets/search_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    // Inisialisasi dari query yang tersimpan di Provider agar state tidak hilang
    _searchController = TextEditingController(
      text: context.read<AppStateProvider>().homeSearchQuery,
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
    final provider = context.watch<AppStateProvider>();
    final filteredAnime = provider.getFilteredAnimeForHome();

    return AppScaffold(
      appBar: AppBar(
        title: Text(
          "AnimeVerse",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: screenWidth * 0.075,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Search Bar menggunakan Widget Baru
            SearchField(
              controller: _searchController,
              hintText: 'Anime Title',
              onChanged: (value) {
                provider.setHomeSearchQuery(value);
              },
              showClear: provider.homeSearchQuery.isNotEmpty,
              onClear: () {
                _searchController.clear();
                provider.setHomeSearchQuery('');
              },
            ),

            // Genre List (Disambungkan dengan Provider)
            GenreList(
              selected: provider.selectedGenre,
              onGenreSelected: (genre) {
                provider.setSelectedGenre(genre);
              },
            ),
            SizedBox(height: screenHeight * 0.03),

            // Anime List (GridView - Disambungkan dengan List Terfilter)
            AnimeView(animeList: filteredAnime),
            SizedBox(height: screenHeight * 0.025),
          ],
        ),
      ),
    );
  }
}
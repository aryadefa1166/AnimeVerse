class Anime {
  final String id;
  final String title;
  final String imagePath;
  final String genre;
  final String rating;
  final String totalEpisodes;
  final String description;

  const Anime({
    required this.id,
    required this.title,
    required this.imagePath,
    required this.genre,
    required this.rating,
    required this.totalEpisodes,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'genre': genre,
      'rating': rating,
      'imagePath': imagePath,
      'totalEpisodes': totalEpisodes,
      'description': description,
    };
  }

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      id: json['id'] as String,
      title: json['title'] as String,
      genre: json['genre'] as String,
      rating: json['rating'] as String,
      imagePath: json['imagePath'] as String,
      totalEpisodes: json['totalEpisodes'] as String,
      description: json['description'] as String,
    );
  }
}
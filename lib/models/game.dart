class Game {
  final String name;
  final int id;
  final dynamic cover;
  final List<dynamic>? platforms;
  final List<dynamic>? releaseDates;
  final List<dynamic>? genres;
  final dynamic rating;
  final dynamic summary;

  Game(
      {required this.name,
      required this.id,
      this.cover,
      this.platforms,
      this.releaseDates,
      this.genres,
      this.rating,
      this.summary});

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
        name: json['name'],
        id: json['id'],
        cover: json['cover'],
        platforms: json['platforms'],
        releaseDates: json['release_dates'],
        rating: json['rating'],
        summary: json['summary'],
        genres: json['genres']);
  }
}

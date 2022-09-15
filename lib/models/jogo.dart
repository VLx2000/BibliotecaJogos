class Jogo {
  final String name;
  final int id;
  final dynamic cover;
  final List<dynamic>? platforms;
  final List<dynamic>? release_dates;
  final dynamic rating;
  final dynamic summary;

  const Jogo(
      {required this.name,
      required this.id,
      this.cover,
      this.platforms,
      this.release_dates,
      this.rating,
      this.summary});

  factory Jogo.fromJson(Map<String, dynamic> json) {
    return Jogo(
        name: json['name'],
        id: json['id'],
        cover: json['cover'],
        platforms: json['platforms'],
        release_dates: json['release_dates'],
        rating: json['rating'],
        summary: json['summary']);
  }
}
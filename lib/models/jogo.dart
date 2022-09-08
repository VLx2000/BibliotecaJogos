class Jogo {
  final String name;
  final int id;
  final dynamic cover;

  const Jogo({
    required this.name,
    required this.id,
    this.cover,
  });

  factory Jogo.fromJson(Map<String, dynamic> json) {
    return Jogo(
      name: json['name'],
      id: json['id'],
      cover: json['cover'],
    );
  }
}

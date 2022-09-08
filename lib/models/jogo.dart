import 'dart:convert';

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

  String gameToJson(List<Jogo> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "cover": cover,
      };
}

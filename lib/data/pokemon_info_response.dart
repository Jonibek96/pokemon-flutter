class PokemonInfoResponse {
  final int id;
  final String name;
  final String image;
  final int height;
  final int weight;

  PokemonInfoResponse(
      {required this.id,
      required this.name,
      required this.image,
      required this.height,
      required this.weight});

  factory PokemonInfoResponse.fromJson(Map<String, dynamic> json) {
    return PokemonInfoResponse(
        id: json['id'],
        name: json['name'],
        image: json['sprites']['front_default'],
        height: json['height'],
        weight: json['weight']);
  }
}

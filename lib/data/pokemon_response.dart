class Pokemon {
  final int id;
  final String name;
  final String url;

  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/$id.png';

  Pokemon({required this.id, required this.name, required this.url});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    final url = json['url'] as String;
    final id = int.parse(url.split('/')[6]);

    return Pokemon(id: id, name: name, url: url);
  }
}

class PokemonResponse {
  final List<Pokemon> pokemonListings;
  final bool canLoadNextPage;

  PokemonResponse(
      {required this.pokemonListings, required this.canLoadNextPage});

  factory PokemonResponse.fromJson(Map<String, dynamic> json) {
    final canLoadNextPage = json['next'] != null;
    final pokemonListings = (json['results'] as List)
        .map((listingJson) => Pokemon.fromJson(listingJson))
        .toList();

    return PokemonResponse(
        pokemonListings: pokemonListings, canLoadNextPage: canLoadNextPage);
  }
}

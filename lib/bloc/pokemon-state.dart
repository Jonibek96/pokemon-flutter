import '../data/pokemon_response.dart';

abstract class PokemonState {}

class PokemonInitial extends PokemonState {}

class PokemonLoadInProgress extends PokemonState {}

class PokemonPageLoadSuccess extends PokemonState {
  final List<Pokemon> pokemonListing;
  final bool canLoadNextPage;

  PokemonPageLoadSuccess(
      {required this.pokemonListing, required this.canLoadNextPage});
}

class PokemonPageLoadFailed extends PokemonState {
  final String error;

  PokemonPageLoadFailed({required this.error});
}

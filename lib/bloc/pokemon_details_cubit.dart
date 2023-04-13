import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_flutter/bloc/pokemon-details.dart';
import 'package:pokemon_flutter/data/pokemon_info_response.dart';
import 'package:pokemon_flutter/data/pokemon_repository.dart';
import 'package:pokemon_flutter/data/pokemon_species.dart';

class PokemonDetailsCubit extends Cubit<PokemonDetails> {
  final _pokemonRepository = PokemonRepository();

  PokemonDetailsCubit()
      : super(PokemonDetails(
            id: 0, name: "", image: "", height: 0, weight: 0, description: ""));

  void getPokemonDetails(int pokemonId) async {
    final responses = await Future.wait([
      _pokemonRepository.getPokemonInfo(pokemonId),
      _pokemonRepository.getPokemonSpeciesInfo(pokemonId)
    ]);

    final pokemonInfo = responses[0] as PokemonInfoResponse;
    final speciesInfo = responses[1] as PokemonSpeciesInfo;

    emit(PokemonDetails(
        id: pokemonInfo.id,
        name: pokemonInfo.name,
        image: pokemonInfo.image,
        height: pokemonInfo.height,
        weight: pokemonInfo.weight,
        description: speciesInfo.description));
  }

  void clearPokemonDetails() => emit(PokemonDetails(
      id: 0, name: "", image: "", height: 0, weight: 0, description: ""));
}

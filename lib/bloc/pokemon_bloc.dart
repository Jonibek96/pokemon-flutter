import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_flutter/bloc/pokemon-state.dart';
import 'package:pokemon_flutter/bloc/pokemon_event.dart';

import '../data/pokemon_repository.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final _pokemonRepository = PokemonRepository();

  PokemonBloc() : super(PokemonInitial()) {
    on<PokemonPageRequest>(mapEventToState);
  }

  void mapEventToState(
      PokemonPageRequest event, Emitter<PokemonState> emit) async {
    emit(PokemonLoadInProgress());
    try {
      final pokemonPageResponse =
          await _pokemonRepository.getPokemonPage(event.page);
      emit(PokemonPageLoadSuccess(
          pokemonListing: pokemonPageResponse.pokemonListings,
          canLoadNextPage: pokemonPageResponse.canLoadNextPage));
    } catch (e) {
      emit(PokemonPageLoadFailed(error: e.toString()));
    }
  }
}

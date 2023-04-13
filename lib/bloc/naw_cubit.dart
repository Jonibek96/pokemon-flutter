import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_flutter/bloc/pokemon_details_cubit.dart';

class NavCubit extends Cubit<int> {
  PokemonDetailsCubit pokemonDetailsCubit;

  NavCubit({required this.pokemonDetailsCubit}) : super(0);

  void showPokemonDetails(int pokemonId) {
    pokemonDetailsCubit.getPokemonDetails(pokemonId);
    emit(pokemonId);
  }

  void popToPokedex() {
    emit(0);
    pokemonDetailsCubit.clearPokemonDetails();
  }
}

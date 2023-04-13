import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_flutter/bloc/naw_cubit.dart';
import 'package:pokemon_flutter/pokemon_details_view.dart';
import 'package:pokemon_flutter/pokemons-view.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavCubit, int>(builder: (context, pokemonId) {
      return Navigator(
        pages: [
          const MaterialPage(child: PokemonsScreen()),
          if (pokemonId != 0) const MaterialPage(child: PokemonDetailsView())
        ],
        onPopPage: (route, result) {
          BlocProvider.of<NavCubit>(context).popToPokedex();
          return route.didPop(result);
        },
      );
    });
  }
}

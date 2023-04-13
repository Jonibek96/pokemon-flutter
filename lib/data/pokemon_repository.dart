import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pokemon_flutter/data/pokemon_info_response.dart';
import 'package:pokemon_flutter/data/pokemon_response.dart';
import 'package:pokemon_flutter/data/pokemon_species.dart';

class PokemonRepository {
  final baseUrl = 'pokeapi.co';
  final client = http.Client();

  Future<PokemonResponse> getPokemonPage(int pageIndex) async {
    final queryParameters = {
      'limit': '200',
      'offset': (pageIndex * 200).toString()
    };
    final uri = Uri.https(baseUrl, 'api/v2/pokemon', queryParameters);

    final response = await client.get(uri);
    final json = jsonDecode(response.body);

    return PokemonResponse.fromJson(json);
  }

  Future<PokemonInfoResponse> getPokemonInfo(int pokemonId) async {
    final uri = Uri.https(baseUrl, 'api/v2/pokemon/$pokemonId');
    final response = await client.get(uri);
    final json = jsonDecode(response.body);
    return PokemonInfoResponse.fromJson(json);
  }

  Future<PokemonSpeciesInfo> getPokemonSpeciesInfo(int pokemonId) async {
    final uri = Uri.https(baseUrl, 'api/v2/ability/$pokemonId');
    final response = await client.get(uri);
    final json = jsonDecode(response.body);
    return PokemonSpeciesInfo.fromJson(json);
  }
}

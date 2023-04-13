import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_flutter/bloc/naw_cubit.dart';
import 'package:pokemon_flutter/bloc/pokemon-state.dart';
import 'package:pokemon_flutter/bloc/pokemon_bloc.dart';
import 'package:pokemon_flutter/home-screen.dart';

class PokemonsScreen extends StatefulWidget {
  const PokemonsScreen({Key? key}) : super(key: key);

  @override
  State<PokemonsScreen> createState() => _PokemonsScreenState();
}

class _PokemonsScreenState extends State<PokemonsScreen> {
  final TextEditingController _searchControllerPokemon = TextEditingController();
  List resultSearchPokemon = [];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          leading: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              child: const Icon(Icons.arrow_back)),
          title: const Text(
            "POKEMON",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        backgroundColor: const Color(0xffcccccc),
        body: BlocBuilder<PokemonBloc, PokemonState>(
          builder: (context, state) {
            if (state is PokemonLoadInProgress) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PokemonPageLoadSuccess) {
                state.pokemonListing.shuffle();
                _searchControllerPokemon.text == "" ? resultSearchPokemon = state.pokemonListing : state.pokemonListing.shuffle();
              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Flexible(
                          child: TextField(
                            cursorColor: Colors.black,
                            controller: _searchControllerPokemon,
                            onChanged: (value){
                              setState(() {
                                List res = [];
                                if(value.isEmpty){
                                  res = state.pokemonListing;
                                }else{
                                  res = state.pokemonListing.where((element) => element.name.toLowerCase().contains(value.toLowerCase())).toList();
                                }
                                resultSearchPokemon = res;
                              });
                            },
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.search),
                              suffixIconColor: Colors.black,
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Введите имя желаемого покемона",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.zero,
                                  bottomRight: Radius.zero,
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                              ),
                              contentPadding: EdgeInsets.all(10.0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.zero,
                                  bottomRight: Radius.zero,
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xFF212121))),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: resultSearchPokemon.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              BlocProvider.of<NavCubit>(context)
                                  .showPokemonDetails(
                                  resultSearchPokemon[index].id);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 2,
                                    blurRadius: 4,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.all(16),
                              padding: EdgeInsets.all(16),
                              child: ListTile(
                                leading: Image.network(
                                    resultSearchPokemon[index].imageUrl),
                                title: Text(resultSearchPokemon[index].name),
                                subtitle: Text(resultSearchPokemon[index].url),
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              );
            } else if (state is PokemonPageLoadFailed) {
              return Center(
                child: Text(state.error),
              );
            } else {
              return Container();
            }
          },
        ));
  }
}

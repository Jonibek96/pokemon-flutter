import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_flutter/pages/about_page.dart';
import 'package:pokemon_flutter/app-navigator.dart';
import 'package:pokemon_flutter/bloc/naw_cubit.dart';
import 'package:pokemon_flutter/bloc/pokemon_bloc.dart';
import 'package:pokemon_flutter/bloc/pokemon_details_cubit.dart';
import 'package:pokemon_flutter/pages/help_page.dart';

import 'bloc/pokemon_event.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final pokemonDetailsCubit = PokemonDetailsCubit();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color(0xffcccccc),
        actions: [
          PopupMenuButton(
              elevation: 0,
              color: Colors.white,
              icon: const Icon(Icons.more_vert, color: Colors.black,),
              itemBuilder: (context) => [
                PopupMenuItem(
                    child: Column(
                      children: [
                        ListTile(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const AboutPage()));
                          },
                          contentPadding: EdgeInsets.zero,
                          title:  Text("About", style: const TextStyle(color: Colors.black)),
                        ),
                        ListTile(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HelpPage()));
                          },
                          contentPadding: EdgeInsets.zero,
                          title:  Text("Help", style: const TextStyle(color: Colors.black)),
                        ),
                      ],
                    )
                )
              ]
          ),
        ],
      ),
      backgroundColor: const Color(0xffcccccc),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.only(bottom: 76),
                child: Image.asset("assets/images/pokemon.png")),
            Container(
              padding: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MultiBlocProvider(providers: [
                              BlocProvider(
                                  create: (context) => PokemonBloc()
                                    ..add(PokemonPageRequest(page: 0))),
                              BlocProvider(
                                  create: (context) => NavCubit(
                                      pokemonDetailsCubit:
                                          pokemonDetailsCubit)),
                              BlocProvider(
                                  create: (context) => pokemonDetailsCubit)
                            ], child: const AppNavigator())),
                  );
                },
                icon: const Icon(Icons.list),
                label: const Text("Список случайный покемон"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white, minimumSize: const Size(150, 56),
                  textStyle: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

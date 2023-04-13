import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_flutter/bloc/pokemon-details.dart';
import 'package:pokemon_flutter/bloc/pokemon_details_cubit.dart';

class PokemonDetailsView extends StatefulWidget {
  const PokemonDetailsView({Key? key}) : super(key: key);

  @override
  State<PokemonDetailsView> createState() => _PokemonDetailsViewState();
}

class _PokemonDetailsViewState extends State<PokemonDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: true,
        title: const Text(
          "DETAILS",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: BlocBuilder<PokemonDetailsCubit, PokemonDetails>(
        builder: (context, details) {
          return details.name.isNotEmpty
              ? SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Container(
                              alignment: const FractionalOffset(0.0, 1.0),
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 0,
                                bottom: 0,
                              ),
                              child: Text(
                                "Имя: ${details.name}",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Color(0xff222222),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              alignment: const FractionalOffset(0.0, 1.0),
                              padding: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 0,
                                bottom: 0,
                              ),
                              child: Text(
                                "ID: ${details.id.toString()}",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff666666),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Stack(children: [
                                Positioned(
                                  top: 250,
                                  left: 0,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 20),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                      color: Colors.white,
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Высота: ${details.height.toString()}",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Масса: ${details.weight.toString()}",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            // backgroundColor: Color(0xff616161),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              details.description,
                                              style: const TextStyle(
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 20,
                                  right: 20,
                                  child: Image(
                                          image: NetworkImage(details.image),
                                          height: 300,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

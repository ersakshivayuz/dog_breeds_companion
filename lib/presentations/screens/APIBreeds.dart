import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/dog_breed_model.dart';
import '../cubits/dog_breed_cubits.dart';
import '../states/dog_breed_state.dart';

class APIBreeds extends StatefulWidget {
  const APIBreeds({super.key});

  @override
  State<APIBreeds> createState() => _APIBreedsState();
}

class _APIBreedsState extends State<APIBreeds> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
        context.read<DogBreedCubit>().fetchBreeds();
      }
    });
  }

  Future<void> _onRefresh() async {
    context.read<DogBreedCubit>().fetchBreeds(isInitial: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: BlocBuilder<DogBreedCubit, DogBreedState>(
          builder: (context, state) {
            if (state is DogBreedLoading && state.isFirstFetch) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is DogBreedError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<DogBreedCubit>().retry(),
                      child: const Text("Retry"),
                    )
                  ],
                ),
              );
            }

            List<DogBreed> breeds = [];
            bool isLoadingMore = false;

            if (state is DogBreedLoading) {
              breeds = state.oldBreeds;
              isLoadingMore = true;
            } else if (state is DogBreedLoaded) {
              breeds = state.breeds;
            }

            if (breeds.isEmpty) {
              return const Center(child: Text("No Results Found"));
            }

            return ListView.separated(
              controller: _scrollController,
              itemCount: breeds.length + (isLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < breeds.length) {
                  final breed = breeds[index];
                  return ListTile(
                    title: Text(breed.name?? ''),
                    subtitle: Text("Dog ID: ${breed.description??''}"),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
              separatorBuilder: (context, index) => const Divider(),
            );
          },
        ),
      ),
    );
  }
}

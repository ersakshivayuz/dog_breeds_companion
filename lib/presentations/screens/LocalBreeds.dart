import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/custom_dog_breed.dart';
import '../cubits/custom_breed_cubit.dart';
import '../states/custom_breed_states.dart';
import 'breed_form_screen.dart';

class LocalBreeds extends StatefulWidget {
  const LocalBreeds({super.key});

  @override
  State<LocalBreeds> createState() => _LocalBreedsState();
}

// final List<String> breeds = ['Fluffy Paws', 'Golden Tail'];

class _LocalBreedsState extends State<LocalBreeds> {
  @override
  void initState() {
    super.initState();
    // context.read<CustomBreedsCubit>().loadBreeds();
    context.read<CustomBreedsCubit>().loadBreeds();
  }

  void _showDeleteDialog(CustomDogBreed breed) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete Breed"),
        content: Text("Are you sure you want to delete '${breed.name}'?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              context.read<CustomBreedsCubit>().deleteBreed(breed.id!);
              Navigator.pop(context);
            },
            child: const Text("Yes"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Custom Dog Breeds',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const BreedFormScreen(),
                      ),
                    );

                    if (result == true) {
                      context.read<CustomBreedsCubit>().loadBreeds(); // ✅ Reload the list
                    }
                  },

                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    'Add New Breed',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 11),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: BlocBuilder<CustomBreedsCubit, CustomBreedsState>(
                builder: (context, state) {
                  if (state is CustomBreedsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CustomBreedsLoaded) {
                    if (state.breeds.isEmpty) {
                      return const Center(
                        child: Text(
                            "No Custom Dog Breeds Available, kindly find the green button above to add the breeds"),
                      );
                    }
                    return ListView.separated(
                      itemCount: state.breeds.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final breed = state.breeds[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    breed.name,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    breed.description,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    "Tags: ${breed.tags}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontStyle: FontStyle.italic),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit,
                                        color: Colors.blue),
                                    onPressed: () async {
                                      final result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => BreedFormScreen(breed: breed),
                                        ),
                                      );

                                      if (result == true) {
                                        context.read<CustomBreedsCubit>().loadBreeds(); // ✅ Reload after update
                                      }
                                    },

                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () => _showDeleteDialog(breed),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    );
                  } else if (state is CustomBreedsError){
                    return Center(child: Text(state.message),);
                  }
                  return const SizedBox();

                },
              ),
            )
          ],
        ),
      ),
    );
  }
}


import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/custom_dog_breed.dart';
import '../../data/repositories/custom_breed_repository.dart';
import '../states/custom_breed_states.dart';

class CustomBreedsCubit extends Cubit<CustomBreedsState> {
  final BreedRepository _repository;

  CustomBreedsCubit(this._repository) : super(CustomBreedsInitial());
  // fetches all the breeds
  void loadBreeds() async {
    emit(CustomBreedsLoading());
    try {
      final breeds = await _repository.fetchAllBreeds();
      emit(CustomBreedsLoaded(breeds));
    } catch (e) {
      emit(CustomBreedsError('Failed to load breeds'));
    }
  }
  void addBreed(CustomDogBreed breed) async {
    try {
      await _repository.insertBreed(breed);

      if (state is CustomBreedsLoaded) {
        final currentBreeds = (state as CustomBreedsLoaded).breeds;
        final updatedBreeds = List<CustomDogBreed>.from(currentBreeds)..add(breed);
        emit(CustomBreedsLoaded(updatedBreeds));
      } else {
        loadBreeds(); // fallback if not loaded
      }
    } catch (e) {
      emit(CustomBreedsError('Failed to add breed'));
    }
  }

  void updateBreed(CustomDogBreed breed) async {
    try {
      await _repository.updateBreed(breed);

      if (state is CustomBreedsLoaded) {
        final currentBreeds = (state as CustomBreedsLoaded).breeds;
        final updatedBreeds = currentBreeds.map((b) {
          return b.id == breed.id ? breed : b;
        }).toList();

        emit(CustomBreedsLoaded(updatedBreeds));
      } else {
        loadBreeds();
      }
    } catch (e) {
      emit(CustomBreedsError('Failed to update breed'));
    }
  }

  void deleteBreed(int id) async {
    try {
      await _repository.deleteBreed(id);

      if (state is CustomBreedsLoaded) {
        final currentBreeds = (state as CustomBreedsLoaded).breeds;
        final updatedBreeds = currentBreeds.where((b) => b.id != id).toList();

        emit(CustomBreedsLoaded(updatedBreeds));
      } else {
        loadBreeds();
      }
    } catch (e) {
      emit(CustomBreedsError('Failed to delete breed'));
    }
  }
}


import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/dog_breed_model.dart';
import '../../data/repositories/dog_breed_repository.dart';
import '../states/dog_breed_state.dart';

class DogBreedCubit extends Cubit<DogBreedState> {
  final DogBreedRepository repository;

  int _page = 1;
  bool _isLastPage = false;
  bool _isFetching = false;
  List<DogBreed> _breeds = [];

  DogBreedCubit(this.repository) : super(DogBreedInitial());

  void fetchBreeds({bool isInitial = false}) async {
    if (_isFetching || _isLastPage) return;

    try {
      _isFetching = true;

      if (isInitial) {
        emit(DogBreedLoading([], isFirstFetch: true));
        _page = 1;
        _isLastPage = false;
        _breeds.clear();
      } else {
        emit(DogBreedLoading(_breeds));
      }

      final newBreeds = await repository.fetchBreed(_page);

      if (newBreeds.isEmpty) {
        _isLastPage = true;
        if (_breeds.isEmpty) {
          emit(DogBreedError("No Results Found"));
        } else {
          emit(DogBreedLoaded(_breeds, true));
        }
      } else {
        _breeds.addAll(newBreeds);
        _page++;
        emit(DogBreedLoaded(_breeds, false));
      }
    } catch (e) {
      emit(DogBreedError("Failed to load data: ${e.toString()}"));
    } finally {
      _isFetching = false;
    }
  }

  void retry() {
    fetchBreeds(isInitial: _breeds.isEmpty);
  }

  void reset() {
    _page = 1;
    _isLastPage = false;
    _breeds.clear();
    emit(DogBreedInitial());
  }
}

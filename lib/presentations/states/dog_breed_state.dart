import 'package:equatable/equatable.dart';
import '../../data/models/dog_breed_model.dart';

abstract class DogBreedState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DogBreedInitial extends DogBreedState {}

class DogBreedLoading extends DogBreedState {
  final List<DogBreed> oldBreeds;
  final bool isFirstFetch;

  DogBreedLoading(this.oldBreeds, {this.isFirstFetch = false});

  @override
  List<Object?> get props => [oldBreeds, isFirstFetch];
}

class DogBreedLoaded extends DogBreedState{
  final List<DogBreed> breeds;
  final bool isLastPage;

  DogBreedLoaded(this.breeds, this.isLastPage);

  @override
  List<Object?> get porps =>[breeds, isLastPage];
}

class DogBreedError extends DogBreedState{
  final String message;

  DogBreedError(this.message);

  @override
  List<Object?> get props => [message];
}


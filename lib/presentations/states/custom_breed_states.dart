import '../../data/models/custom_dog_breed.dart';

abstract class CustomBreedsState {}

class CustomBreedsInitial extends CustomBreedsState {}
class CustomBreedsLoading extends CustomBreedsState {}
class CustomBreedsLoaded extends CustomBreedsState {
  final List<CustomDogBreed> breeds;
  CustomBreedsLoaded(this.breeds);
}
class CustomBreedsError extends CustomBreedsState {
  final String message;
  CustomBreedsError(this.message);
}
class CustomBreedCreated extends CustomBreedsState {}
class CustomBreedUpdated extends CustomBreedsState {}
class CustomBreedDeleted extends CustomBreedsState {}

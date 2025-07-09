class DogBreed {
  final String?name;
  final String? description;

  DogBreed({
    required this.name,
    required this.description
  });
  factory DogBreed.fromJson(Map<dynamic, dynamic> json){
    final attributes = json['attributes'];
    return DogBreed(
      name: attributes['name']??'',
        description: attributes['description']??'',

    );

  }


}
 
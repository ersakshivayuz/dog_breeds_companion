class DogBreed {
  final String id;
  final String name;
  final String description;

  DogBreed({
    required this.id,
    required this.name,
    required this.description
  });

  factory DogBreed.fromJson(Map<dynamic, dynamic> json)=>
      DogBreed(
          id: json['id'],
          name: json['title'],
          description: json['description']
      );

  Map<String,dynamic> toJson()=>{
    'id': id,
    'name': name,
    'description': description
  };
}



// This represents one row from your SQLite breeds table.
class CustomDogBreed {
  final int? id;
  final String name;
  final String description;
  final String tags;

  CustomDogBreed({
    this.id,
    required this.name,
    required this.description,
    required this.tags,
  });
  // call toMap() when Inserting a new breed into the database and updating the existing breed

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'tags': tags,
    };
  }
  //use fromMap when reading the data from the data base and we are fetching the data using SELECT query

  factory CustomDogBreed.fromMap(Map<String, dynamic> map) {
    return CustomDogBreed(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      tags: map['tags'],
    );
  }
}
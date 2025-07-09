import 'dart:convert';
import '../models/dog_breed_model.dart';
import 'package:http/http.dart' as http;

class DogBreedRepository {
  // static const int _fetchLimit = 15;
  final String _baseUrl = "https://dogapi.dog/api/v2/breeds";

  Future<List<DogBreed>> fetchBreed(int page) async {
    final url = "$_baseUrl?page[number]=$page";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final List<dynamic> data = decoded['data'];

        return data.map((e) => DogBreed.fromJson(e)).toList();
      } else {
        throw Exception("Failed to load breeds: ${response.statusCode}");
      }
    } catch (err) {
      print("Error: $err");
      return [];
    }
  }
}

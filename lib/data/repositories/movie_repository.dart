import 'dart:convert';
import 'package:http/http.dart';
import '../models/genre_model.dart';

class MovieRepository {
  final Client client = Client();

  static const String base_url = 'https://api.themoviedb.org/3';

  static const String language = 'ko-KR';

  static const String region = 'KR';

  static const String api_key =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJkZTBiMmI1YWExMjZjOTAyM2VhODM0MjNjM2ZlY2M5NCIsIm5iZiI6MTczNjIyNzEwNS44OCwic3ViIjoiNjc3Y2I5MjE3YzllODBiOWU4NzI0MjNkIiwic2NvcGVzIjpbImFwaV9yZWFkIl0sInZlcnNpb24iOjF9.iB3KglOdDW5eXAaTwi5z8M12K15Bwih78EO3fNcreCI';

  Future<List<GenreModel>> getAllGenres() async {
    final Uri url = Uri.parse(
        '${base_url}/genre/movie/list?language=${language}&region=${region}');
    final headers = {'Authorization': 'Bearer ${api_key}'};

    final response = await client.get(url, headers: headers);

    final List<GenreModel> results = [];

    final json = jsonDecode(response.body);
    for (var genreJson in json['genres']) {
      results.add(GenreModel.fromJson(genreJson));
    }

    return results;
  }
}

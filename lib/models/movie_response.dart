import 'package:neosurge_task2/models/movies.dart';

class MovieApiResponse {
  final List<Movies> searchResults;
  final String totalResults;
  final String response;

  MovieApiResponse({
    required this.searchResults,
    required this.totalResults,
    required this.response,
  });

  factory MovieApiResponse.fromJson(Map<String, dynamic> json) {
    return MovieApiResponse(
      searchResults: (json['Search'] as List)
          .map((movieData) => Movies.fromJson(movieData))
          .toList(),
      totalResults: json['totalResults'],
      response: json['Response'],
    );
  }
}
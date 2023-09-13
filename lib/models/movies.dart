class Movies {
  final String title;
  final String poster;
   String imdbRating;
   String genre;
  final String id;

  Movies({
    required this.title,
    required this.poster,
    required this.imdbRating,
    required this.genre,
    required this.id,
  });

  factory Movies.fromJson(Map<String, dynamic> parsedJson) {
    return Movies(
        title: parsedJson['Title'] ?? "",
        poster: parsedJson['Poster'] ?? "",
        imdbRating: parsedJson['imdbRating'] ?? "",
        genre: parsedJson['Genre'] ?? "",
        id: parsedJson['imdbID'] ?? "");
  }
}
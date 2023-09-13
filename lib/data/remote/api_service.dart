import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:neosurge_task2/models/movie_response.dart';
import 'package:neosurge_task2/models/movies.dart';
import 'package:neosurge_task2/utils/constants.dart';
import 'app_exception.dart';
import 'package:http/http.dart' as http;
class ApiService {
  static final ApiService instance = ApiService._initialize();

  ApiService._initialize();

  factory ApiService() {
    return instance;
  }

  Future<List<Movies>> getSearchResponse({required String query}) async {
    try {
      final response = await http.get(Uri.parse(
          '${Constant.baseUrl}${Constant.searchEndPoint}$query&apikey=${Constant.apiKey}'));
      log(response.body);
      dynamic parsedJson = returnResponse(response);
      MovieApiResponse movies = MovieApiResponse.fromJson(parsedJson);
      return movies.searchResults;
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      log('${ApiService().runtimeType.toString()} error caught with usda api is $e');
      rethrow;
    }
  }

  Future<void> getMovieDetails({required String id, required List<Movies>list, required int index}) async {
    try {
      final response = await http.get(Uri.parse(
          '${Constant.baseUrl}${Constant.idEndPoint}$id&apikey=${Constant.apiKey}'));
      log(response.body);
      dynamic parsedJson = returnResponse(response);
      list[index].imdbRating = parsedJson['imdbRating'];
      list[index].genre = parsedJson['Genre'];
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      log('${ApiService().runtimeType.toString()} error caught with usda api is $e');
      rethrow;
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
      case 404:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while communication with server' ' with status code : ${response.statusCode}');
    }
  }
}
import 'dart:developer';

import 'package:neosurge_task2/models/movies.dart';

import '../data/remote/api_service.dart';

class MoviesRepo {
  final ApiService _apiService = ApiService.instance;

  Future<List<Movies>> getFoodCalories({required String query}) async {
    List<Movies> response = [];
    try {
      response = await _apiService.getSearchResponse(query: query);
      await getMovieDetails(response);
      log("data in repo class is:- $response");
    } catch (e) {
      log(e.toString());
    }
    return response;
  }

  Future<void> getMovieDetails(List<Movies> list) async {
    for (int i = 0; i < list.length; i++) {
      await _apiService.getMovieDetails(id: list[i].id, list: list, index: i);
    }
  }
}
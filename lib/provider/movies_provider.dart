import 'package:flutter/cupertino.dart';
import 'package:neosurge_task2/models/movies.dart';
import 'package:neosurge_task2/repository/movie_repository.dart';

class MoviesProvider extends ChangeNotifier {
  String _userInput = '';

  List<Movies>list = [];

  bool _isLoading = false;

  String get userInput => _userInput;

  set userInput(value) {
    _userInput = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  void getMoviesList() async{
    list=[];
    list = await MoviesRepo().getFoodCalories(query: _userInput);
    _isLoading=false;
    notifyListeners();
  }

}
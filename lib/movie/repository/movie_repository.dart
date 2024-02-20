import 'package:flutter_movie_db/movie/models/movie_model.dart';

abstract class MovieRepository {
  Future<MovieResponseModel> getDiscover({int page = 1});
}

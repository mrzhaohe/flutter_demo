import 'package:topmovies/models/movie.dart';


abstract class API {
  Future<MovieEnvelop> getMovieList(int start);
  Future<Movie> getMovie(String movieId);
}

class MockApi extends API {
  @override
  Future<Movie> getMovie(String movieId) {
    return createMovieWithTitle('我是电影 $movieId');
  }
  @override
  Future<MovieEnvelop> getMovieList(int start) {
    return null;
  }

}

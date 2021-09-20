import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _apiKey = 'a3996b4caf8a838bbc348e7e1f443b80';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;
  //Constructor
  MoviesProvider() {
    print('MoviesProviderInicializado');
    this.getOnDisplayMovies();
    this.getPopularMovies();
  }

  //Ejemplo sin metodo
  // final Map<String, dynamic> decodedData = json.decode(response.body);
  // if (response.statusCode != 200) return print('error');
  // print(nowPlayinResponse.results[0].title);

  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    var url = Uri.https(this._baseUrl, endpoint, {
      'api_key': _apiKey,
      'language': _language,
      'page': '$page',
    });
    //Await the http get repsonse, the decode the json-
    final response = await http.get(url);
    return response.body;
  }

  //Metodo de on view Movies
  getOnDisplayMovies() async {
    final jsonData = await this._getJsonData('3/movie/now_playing');

    /** Se recoje el Json en   { response.body } */
    final nowPlayinResponse = NowPlayingResponse.fromJson(jsonData);
    
    /** onDisplayMovies obtiene los valores  { results = movies } del Json*/
    this.onDisplayMovies = nowPlayinResponse.results;
    notifyListeners(); //Redibujar widgets
  }

  //Metodo on popular Movies
  getPopularMovies() async {
    _popularPage++;

    final jsonData = await this._getJsonData('3/movie/popular', _popularPage);

    /** Se recoje el Json en { response.body } */
    final popularResponse = PopularResponse.fromJson(jsonData);
    /**onDisplayMovies obtiene los valores { results = movies } del Json*/
    this.popularMovies = [...popularMovies, ...popularResponse.results];
    // print('Valor pelis: ${popularResponse.results.length}');
    notifyListeners(); //Redibujar widgets
  }

  getMovieCast(int movieId) async {
    //TODO: revisar el mapa
  }
}

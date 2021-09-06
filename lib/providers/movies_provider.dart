import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  String _apiKey = 'a3996b4caf8a838bbc348e7e1f443b80';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  //Constructor
  MoviesProvider() {
    print('MoviesProviderInicializado');
    this.getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    print('getOnDisplayMovies');
    var url = Uri.https(this._baseUrl, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    });

    //Await the http get repsonse, the decode the json-
    final response = await http.get(url);
    final nowPlayinResponse = NowPlayingResponse.fromJson(response.body);
    // final Map<String, dynamic> decodedData = json.decode(response.body);
    // if (response.statusCode != 200) return print('error');

    // print(nowPlayinResponse.results[0].title);

    this.onDisplayMovies = nowPlayinResponse.results;
    notifyListeners(); //REdibujar widgets
  }
}

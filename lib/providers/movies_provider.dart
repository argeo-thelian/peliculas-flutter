import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  String _apiKey = 'a3996b4caf8a838bbc348e7e1f443b80';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

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
    // if (response.statusCode != 200) return print('error');

    print(response.body);
  }
}

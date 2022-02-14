import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:places_autocomplete/src/models/place.dart';
import 'dart:convert' as convert;

// ignore: unused_import
import 'package:places_autocomplete/src/models/place_search.dart';

class PlacesService {
  final key = 'AIzaSyAPjPbrKO3uRQ80E0ue6g4XoSgBIcNucgQ';

  //Future<List<PlaceSearch>> getAutocomplete(String search) async {
    //var url =
      //  'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=(cities)&key=$key';
    //var response = await http.get(url);
    //var json = convert.jsonDecode(response.body);
    //var jsonResults = json['predictions'] as List;
    //return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  //}

  Future<Place> getPlace(String placeId) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/details/json?fields=name%2Crating%2Cformatted_address&place_id=$placeId&key=$key';
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String, dynamic>;
    return Place.fromJson(jsonResult);
  }

  Future<List<Place>> getPlaces(
      double lat, double lng, String placeType) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=gym&location=$lat,$lng&radius=2000&type=gym&rankby=distance&key=$key';
    // var url = 'https://maps.googleapis.com/maps/api/place/textsearch/json?location=$lat,$lng&type=$placeType&rankby=distance&key=$key';
    var response = await http.get(url);
    // var json = convert.jsonDecode(response.body);
    var json = jsonDecode(response.body);

    var jsonResults = json['results'] as List;
    // return jsonResults.map((place) => Place.fromJson(place)).toList();
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }
}

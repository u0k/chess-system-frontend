import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/texture.dart';
import '../utils/constants.dart';

Future<List<Texture_>> fetchTextures() async {
  var response = await http.get(
    Uri.http(BASE_URL, "/api/texture"),
    headers: {
      "Access-Control-Allow-Origin": "*",
    },
  );
  if (response.statusCode == 200) {
    List<dynamic> parsedListJson = jsonDecode(response.body);
    List<Texture_> textureList = List<Texture_>.from(
        parsedListJson.map<Texture_>((dynamic i) => Texture_.fromJson(i)));
    return textureList;
  } else {
    throw Exception('Nepavyko gauti naujienų sąrašo.');
  }
}

Future<bool> addTexture(String imageData, String name) async {
  bool didUpload = false;
  var response = await http.post(
    Uri.http(BASE_URL, "/api/texture/add"),
    body: jsonEncode({"imageData": imageData, "name": name}),
    headers: {
      "Access-Control-Allow-Origin": "*",
      "content-type": "application/json",
    },
  );
  if (response.statusCode == 200) {
    didUpload = true;
    return didUpload;
  } else {
    if (response.statusCode == 404 || response.statusCode == 401) {
      return didUpload;
    }
    return false;
    //todo errors(neteisingi duomenys, network error etc)
  }
}

Future<bool> deleteTexture(textureId) async {
  bool didDelete = false;

  var response = await http.delete(
    Uri.http(BASE_URL, "/api/texture/$textureId"),
    headers: {
      "Access-Control-Allow-Origin": "*",
    },
  );

  if (response.statusCode == 200) {
    didDelete = true;
    return didDelete;
  } else {
    throw Exception('Nepavyko gauti renginių sąrašo.');
  }
}

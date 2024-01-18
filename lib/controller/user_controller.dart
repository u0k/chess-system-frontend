import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';
import '../utils/constants.dart';

Future<User> fetchUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final int? usrId = prefs.getInt('usrId');
  var response = await http.get(
    Uri.http(BASE_URL, "/api/user/$usrId"),
    headers: {
      "Access-Control-Allow-Origin": "*",
      "content-type": "application/json",
    },
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> userMap = jsonDecode(response.body);
    var tagObjsJson = User.fromJson(userMap);
    return tagObjsJson;
  } else {
    throw Exception('Nepavyko gauti renginių sąrašo.');
  }
}

Future<List<User>> fetchUsers() async {
  var response = await http.get(
    Uri.http(BASE_URL, "/api/user"),
    headers: {
      "Access-Control-Allow-Origin": "*",
    },
  );
  if (response.statusCode == 200) {
    List<dynamic> parsedListJson = jsonDecode(response.body);
    List<User> usersList = List<User>.from(
        parsedListJson.map<User>((dynamic i) => User.fromJson(i)));
    return usersList;
  } else {
    throw Exception('Nepavyko gauti naujienų sąrašo.');
  }
}

Future<bool> updateProfile(User userObj) async {
  bool isSaved = false;
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final int? usrId = prefs.getInt('usrId');
  var response = await http.put(
    Uri.http(BASE_URL, "/api/user/update/$usrId",
          {'username': userObj.username, 'emailAddress': userObj.emailAddress}),
    headers: {
      "Access-Control-Allow-Origin": "*",
      "content-type": "application/json",
    },
  );
  if (response.statusCode == 200) {
    isSaved = true;
    return isSaved;
  } else {
    throw Exception('Nepavyko startuoti renginio.');
  }
}

Future<bool> registerUser(User userObj) async {
  bool didRegister = false;
  var response = await http.post(
    Uri.http(BASE_URL, "/api/user/register"),
    body: jsonEncode(userObj),
    headers: {
      "Access-Control-Allow-Origin": "*",
      "content-type": "application/json",
    },
  );
  if (response.statusCode == 200) {
    didRegister = true;
    return didRegister;
  } else {
    if (response.statusCode == 404 || response.statusCode == 401) {
      return didRegister;
    }
    return false;
    //todo errors(neteisingi duomenys, network error etc)
  }
}

Future<bool> loginUser(User userObj) async {
  bool didLogin = false;
  var response = await http.post(
    Uri.http(BASE_URL, "/api/user/login"),
    body: jsonEncode(userObj),
    headers: {
      "Access-Control-Allow-Origin": "*",
      "content-type": "application/json",
    },
  );
  if (response.statusCode == 200) {
    didLogin = true;
    var usrId = jsonDecode(response.body)['id'] as int;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('usrId', usrId);
    return didLogin;
  } else {
    if (response.statusCode == 404 || response.statusCode == 401) {
      return didLogin;
    }
    return false;
    //todo errors(neteisingi duomenys, network error etc)
  }
}

Future<bool> updateCurrency(User userObj) async {
  bool isSaved = false;

  final int? usrId = userObj.id;
  var response = await http.put(
    Uri.http(BASE_URL, "/api/user/update/$usrId",
        {'currency': '${userObj.currency}'}),
    headers: {
      "Access-Control-Allow-Origin": "*",
      "content-type": "application/json",
    },
  );
  if (response.statusCode == 200) {
    isSaved = true;
    return isSaved;
  } else {
    throw Exception('Nepavyko startuoti renginio.');
  }
}

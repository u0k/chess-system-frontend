import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/admin.dart';
import '../utils/constants.dart';

Future<Admin> fetchAdmin() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final int? adminId = prefs.getInt('adminId');
  var response = await http.get(
    Uri.http(BASE_URL, "/api/admin/$adminId"),
    headers: {
      "Access-Control-Allow-Origin": "*",
      "content-type": "application/json",
    },
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> userMap = jsonDecode(response.body);
    var tagObjsJson = Admin.fromJson(userMap);
    return tagObjsJson;
  } else {
    throw Exception('Nepavyko gauti renginių sąrašo.');
  }
}

Future<bool> loginAdmin(Admin adminObj) async {
  bool didLogin = false;
  var response = await http.post(
    Uri.http(BASE_URL, "/api/admin/login"),
    body: jsonEncode(adminObj),
    headers: {
      "Access-Control-Allow-Origin": "*",
      "content-type": "application/json",
    },
  );
  if (response.statusCode == 200) {
    didLogin = true;
    var adminId = jsonDecode(response.body)['id'] as int;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('adminId', adminId);
    return didLogin;
  } else {
    if (response.statusCode == 404 || response.statusCode == 401) {
      return didLogin;
    }
    return false;
    //todo errors(neteisingi duomenys, network error etc)
  }
}
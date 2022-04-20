import 'package:demo/constants/variables.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiHelper {
  String? token = "";

  Future<http.Response?> postRequest(
      {required String uri, required String body}) async {
    await getToken();
    Map<String, String>? headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
    http.Response response;
    try {
      response = await http.post(Uri.parse("$baseUrl$uri"),
          headers: headers, body: body);
      debugPrint(
          "response.statusCode in post request : ${response.statusCode}");
      return response;
    } catch (err) {
      debugPrint('error of post request : $err');
      // err from server
      // Navigate to main
    }
  }

  Future<http.Response?> putRequest(
      {required String uri, required String body}) async {
    await getToken();
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
    http.Response response;
    try {
      response = await http.put(Uri.parse("$baseUrl$uri"),
          headers: headers, body: body);
      debugPrint("response.statusCode in put request : ${response.statusCode}");
      return response;
    } catch (err) {
      debugPrint('error of put request : $err');
      // err from server
      // Navigate to main
    }
  }

  Future<http.Response?> getRequest({required String uri}) async {
    await getToken();
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
    http.Response response;
    try {
      response = await http.get(Uri.parse("$baseUrl$uri"), headers: headers);
      debugPrint("response.statusCode in get request : ${response.statusCode}");
      return response;
    } catch (err) {
      debugPrint('error of get request : $err');
      // err from server
      // Navigate to main
    }
  }

  Future<http.Response?> deleteRequest({required String uri}) async {
    await getToken();
    Map<String, String> headers = {
      "Content-type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };
    http.Response response;
    try {
      response = await http.delete(Uri.parse("$baseUrl$uri"), headers: headers);
      debugPrint(
          "response.statusCode in delete request : ${response.statusCode}");
      return response;
    } catch (err) {
      debugPrint('error of delete request : $err');
      // err from server
      // Navigate to main
    }
  }

  Future getToken() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    token = sharedPref.getString(accessToken) ?? '';
  }
}

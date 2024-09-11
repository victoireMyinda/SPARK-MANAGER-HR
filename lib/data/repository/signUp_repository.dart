// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:sparkmanager_rh/utils/string.util.dart';

class SignUpRepository {
  static Future<Map<String, dynamic>> signupAgent(Map data) async {
    // Vérifier la connexion Internet
    try {
      final response = await InternetAddress.lookup('www.google.com');
      if (response.isNotEmpty) {
        if (kDebugMode) {
          print("connected");
        }
      }
    } on SocketException catch (err) {
      return {"status": 0, "message": "Pas de connexion internet"};
    }

    var headers = {'Content-Type': 'application/json'};

    var request = http.Request(
        'POST',
        Uri.parse(
            "https://findagent-535646416594.europe-west2.run.app/api/v1/user/agent/signup"));

    request.body = json.encode(data);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      Map? responseData = responseJson['data'];
      String? message = responseJson['message'];

      return {"status": statusCode, "data": responseData, "message": message};
    } else {
      String? message = responseJson['message'];
      return {"status": statusCode, "message": message};
    }
  }

  static Future<Map<String, dynamic>> presenceAgent(Map data) async {
    // Vérifier la connexion Internet
    try {
      final response = await InternetAddress.lookup('www.google.com');
      if (response.isNotEmpty) {
        if (kDebugMode) {
          print("connected");
        }
      }
    } on SocketException catch (err) {
      return {"status": 0, "message": "Pas de connexion internet"};
    }

    var headers = {'Content-Type': 'application/json'};

    var request = http.Request(
        'POST',
        Uri.parse(
            "https://findagent-535646416594.europe-west2.run.app/api/v1/dashboard/point"));

    request.body = json.encode(data);

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 201) {
      Map? responseData = responseJson['data'];
      String? message = responseJson['message'];

      return {"status": statusCode, "data": responseData, "message": message};
    } else {
      String? message = responseJson['message'];
      return {"status": statusCode, "message": message};
    }
  }

  static Future<Map<String, dynamic>> login(Map data) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            "https://findagent-535646416594.europe-west2.run.app/api/v1/user/agent/login"));

    request.body = json.encode(data);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      // String? token = responseJson['token'];
      String? message = responseJson['message'];
      Map? data = responseJson['data'];

      // prefs.setString("token", token.toString());
      return {
        // "token": token,
        "status": statusCode,
        "message": message,
        "data": data
      };
    } else {
      String message = responseJson['message'];
      return {"status": statusCode, "message": message};
    }
  }

  static Future<Map<String, dynamic>> createHoraire(Map data) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            "https://findagent-535646416594.europe-west2.run.app/api/v1/dashboard/schedule"));

    request.body = json.encode(data);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 201) {
      // String? token = responseJson['token'];
      String? message = responseJson['message'];
      Map? data = responseJson['data'];

      // prefs.setString("token", token.toString());
      return {
        // "token": token,
        "status": statusCode,
        "message": message,
        "data": data
      };
    } else {
      String message = responseJson['message'];
      return {"status": statusCode, "message": message};
    }
  }

  static Future<Map<String, dynamic>> getHoraire() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString("token");

    // var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://findagent-535646416594.europe-west2.run.app/api/v1/dashboard/schedule'));

    // request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      // String? message = responseJson['message'];
      List? data = responseJson['data'];
      return {"status": statusCode, "data": data};
    } else {
      // String message = responseJson['message'];
      return {
        "status": statusCode,
      };
    }
  }

  static Future<Map<String, dynamic>> getPresenceByAgent(id) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString("token");

    // var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://findagent-535646416594.europe-west2.run.app/api/v1/dashboard/point?agent=$id'));

    // request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      List? data = responseJson['data'];
      return {"status": statusCode, "data": data};
    } else {
      return {
        "status": statusCode,
      };
    }
  }

   static Future<Map<String, dynamic>> getAllPresence() async {
    
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://findagent-535646416594.europe-west2.run.app/api/v1/dashboard/point'));

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      List? data = responseJson['data'];
      return {"status": statusCode, "data": data};
    } else {
      return {
        "status": statusCode,
      };
    }
  }

  static Future<Map<String, dynamic>> gettAllAgent() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // String? token = prefs.getString("token");

    // var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://findagent-535646416594.europe-west2.run.app/api/v1/agent'));

    // request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    String responseBody = await response.stream.bytesToString();

    Map<String, dynamic> responseJson = json.decode(responseBody);

    int statusCode = responseJson['code'];

    if (statusCode == 200) {
      String? message = responseJson['message'];
      List? data = responseJson['users'];
      return {"status": statusCode, "message": message, "data": data};
    } else {
      String message = responseJson['message'];
      return {"status": statusCode, "message": message};
    }
  }

  
}

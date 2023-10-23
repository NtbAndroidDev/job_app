import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:jobhub/models/request/auth/login_model.dart';
import 'package:jobhub/models/request/auth/profile_update_model.dart';
import 'package:jobhub/models/response/auth/login_res_model.dart';
import 'package:jobhub/models/response/auth/profile_model.dart';
import 'package:jobhub/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/request/auth/signup_model.dart';

class AuthHelper {
  static var client = https.Client();

  static Future<bool> login(LoginModel model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json'
    };
    var url = Uri.https(Config.apiUrl, Config.loginUrl);
    var response = await client.post(
      url, headers: requestHeaders, body: jsonEncode(model));

    if(response.statusCode == 200){
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = loginResponseModelFromJson(response.body).userToken;
      String userId = loginResponseModelFromJson(response.body).id;
      String profile = loginResponseModelFromJson(response.body).profile;

      await prefs.setString('token', token);
      await prefs.setString('userId', userId);
      await prefs.setString('profile', profile);
      await prefs.setBool('loggedIn', true);

      return true;
    }else{
      return false;
    }
  }


  static Future<bool> signup(SignupModel model) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.https(Config.apiUrl, Config.signupUrl);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }


  static Future<bool> updateProfile(ProfileUpdateReq model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.profileUrl);
    var response = await client.put(
      url,
      headers: requestHeaders,
      body: jsonEncode(model),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }


  static Future<ProfileRes> getProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.profileUrl);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var profile = profileResFromJson(response.body);
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setString('userId', profile.id);
      await prefs.setString('profile', profile.profile);

      return profile;
    } else {
      throw Exception("Failed to get the profile");
    }
  }



}

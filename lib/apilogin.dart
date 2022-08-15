import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tela_login_goga/pages/homepage.dart';

class LoginApi {
  static Future<String?> login(String user, String password) async {
    final response =
        await http.post(Uri.parse('https://tanilo.herokuapp.com/oauth/token'),
            headers: {
              "Content-Type": "application/x-www-form-urlencoded",
              "Authorization": "Basic ZHNjYXRhbG9nOmRzY2F0YWxvZzEyMw==",
            },
            encoding: Encoding.getByName('utf-8'),
            body: "grant_type=password&password=$password&username=$user");
    print(response.body);

    if (response.statusCode == 200) {
      print('Logado com Sucesso');
    } else {
      print("Falhou");
    }
  }
}

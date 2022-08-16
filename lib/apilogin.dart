import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tela_login_goga/domain/usuario.dart';


class LoginApi {


  static Future<Usuario?> login(String user, String password) async {
    final response =
    await http.post(Uri.parse('https://tanilo.herokuapp.com/oauth/token'),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Authorization": "Basic ZHNjYXRhbG9nOmRzY2F0YWxvZzEyMw==",
        },
        encoding: Encoding.getByName('utf-8'),
        body: "grant_type=password&password=$password&username=$user");


    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('jUsuario', response.body);
      Map<String, dynamic> mapResponse = json.decode(response.body);
      var usuario = Usuario.fromJson(mapResponse);
      return usuario;
    }
  }
}
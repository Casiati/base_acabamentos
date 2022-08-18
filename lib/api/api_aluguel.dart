import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/usuario.dart';

class AluguelApi {
  static Future<String?> aluguel(token) async {
    final prefs = await SharedPreferences.getInstance();
    var jUsuario = prefs.getString("jUsuario");
    Map<String, dynamic> mapResponse = json.decode(jUsuario!);
    var usuario = Usuario.fromJson(mapResponse);
    var token = usuario.accessToken;
    var response = await http.get(
      Uri.parse('https://tanilo.herokuapp.com/alugueis'),
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
    } else {print('Falhou');}
  }
}

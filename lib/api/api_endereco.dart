import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/endereco.dart';
import '../domain/usuario.dart';

class EnderecoApi {
  static Future<List<Endereco?>?> getEndereco() async {
    final prefs = await SharedPreferences.getInstance();
    var jUsuario = prefs.getString("jUsuario");
    Map<String, dynamic> mapResponse = json.decode(jUsuario!);
    var usuario = Usuario.fromJson(mapResponse);

    var token = usuario.accessToken;
    var headers = {"Authorization": "Bearer $token"};
    var url = Uri.parse('https://tanilo.herokuapp.com/enderecos');
    var response = await http.get(url, headers: headers);

    utf8.decode(response.bodyBytes);
    List listResponse = json.decode(utf8.decode(response.bodyBytes));
    final endereco = <Endereco>[];
    for (Map<String, dynamic> map in listResponse) {
      Endereco p = Endereco.fromJson(map);
      endereco.add(p);
    }
    return endereco;
  }
}

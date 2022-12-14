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


  static Future<Endereco?> postEndereco(
      bairro, cep, localidade, logradouro, numero, uf) async {
    final prefs = await SharedPreferences.getInstance();
    var jUsuario = prefs.getString("jUsuario");
    Map<String, dynamic> mapResponse = json.decode(jUsuario!);
    var usuario = Usuario.fromJson(mapResponse);
    var token = usuario.accessToken;

    var headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    };
    String body =
        """{"bairro": "$bairro","cep": "$cep","localidade": "$localidade","logradouro": "$logradouro","numero": "$numero","uf": "$uf"}""";

    var url = Uri.parse('https://tanilo.herokuapp.com/enderecos');
    var response = await http.post(url, headers: headers, body: body);
    utf8.decode(response.bodyBytes);
    Map<String, dynamic> idResponse =
        json.decode(utf8.decode(response.bodyBytes));
    var endereco = Endereco.fromJson(idResponse);
    return endereco;
  }

  static Future<Endereco?> putEndereco(
      bairro, cep, id, localidade, logradouro, numero, uf) async {
    final prefs = await SharedPreferences.getInstance();
    var jUsuario = prefs.getString("jUsuario");
    Map<String, dynamic> mapResponse = json.decode(jUsuario!);
    var usuario = Usuario.fromJson(mapResponse);
    var token = usuario.accessToken;

    var headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    };
    String body =
        """{"bairro": "$bairro","cep": "$cep","localidade": "$localidade","logradouro": "$logradouro","numero": "$numero","uf": "$uf"}""";


    var url = Uri.parse('https://tanilo.herokuapp.com/enderecos/$id');
    var response = await http.put(url, headers: headers, body: body);
    utf8.decode(response.bodyBytes);
    Map<String, dynamic> id2Response =
        json.decode(utf8.decode(response.bodyBytes));
    var endereco = Endereco.fromJson(id2Response);
    return endereco;
  }

  static Future<Endereco?> deleteEndereco(id) async {
    final prefs = await SharedPreferences.getInstance();
    var jUsuario = prefs.getString("jUsuario");
    Map<String, dynamic> mapResponse = json.decode(jUsuario!);
    var usuario = Usuario.fromJson(mapResponse);
    var token = usuario.accessToken;

    var headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    };

    var url = Uri.parse('https://tanilo.herokuapp.com/enderecos/$id');
    await http.delete(url, headers: headers);
    return null;


  }
}


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/cliente.dart';
import '../domain/usuario.dart';

class ClienteApi {
  static Future<List<Cliente?>?> getCliente() async {
    final prefs = await SharedPreferences.getInstance();
    var jUsuario = prefs.getString("jUsuario");
    Map<String, dynamic> mapResponse = json.decode(jUsuario!);
    var usuario = Usuario.fromJson(mapResponse);
    var token = usuario.accessToken;

    var headers = {"Authorization": "Bearer $token"};
    var url = Uri.parse('https://tanilo.herokuapp.com/clientes');
    var response = await http.get(url, headers: headers);


    utf8.decode(response.bodyBytes);
    List listResponse = json.decode(utf8.decode(response.bodyBytes));
    final cliente = <Cliente>[];
    for (Map<String, dynamic> map in listResponse) {
      Cliente p = Cliente.fromJson(map);
      cliente.add(p);
      print(p.nome);
      print(p.endereco!.id);
    }
    return cliente;
  }


  static Future<Cliente?> postCliente(
      nome, id, cpfCnpj, telefone1, telefone2, idEndereco) async {
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
    """{"telefone2": "$telefone2","cep": "$idEndereco","cpfCnpj": "$cpfCnpj","nome": "$nome","telefone1": "$telefone1"}""";

    var url = Uri.parse('https://tanilo.herokuapp.com/clientes');
    var response = await http.post(url, headers: headers, body: body);
    utf8.decode(response.bodyBytes);
    Map<String, dynamic> idResponse =
    json.decode(utf8.decode(response.bodyBytes));
    var cliente = Cliente.fromJson(idResponse);
    return cliente;
  }

  static Future<Cliente?> putCliente(
      nome, id, cpfCnpj, telefone1, telefone2, idEndereco) async {
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
    """{"telefone2": "$telefone2","cep": "$idEndereco","cpfCnpj": "$cpfCnpj","nome": "$nome","telefone1": "$telefone1"}""";


    var url = Uri.parse('https://tanilo.herokuapp.com/clientes/$id');
    var response = await http.put(url, headers: headers, body: body);
    utf8.decode(response.bodyBytes);
    Map<String, dynamic> id2Response =
    json.decode(utf8.decode(response.bodyBytes));
    var cliente = Cliente.fromJson(id2Response);
    return cliente;
  }

  static Future<Cliente?> deleteCliente(id) async {
    final prefs = await SharedPreferences.getInstance();
    var jUsuario = prefs.getString("jUsuario");
    Map<String, dynamic> mapResponse = json.decode(jUsuario!);
    var usuario = Usuario.fromJson(mapResponse);
    var token = usuario.accessToken;

    var headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    };

    var url = Uri.parse('https://tanilo.herokuapp.com/clientes/$id');
    await http.delete(url, headers: headers);
    return null;


  }
}


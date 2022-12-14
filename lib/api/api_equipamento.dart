import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/equipamento.dart';
import '../domain/usuario.dart';

class EquipamentoApi {
  static Future<List<Equipamento?>?> getEquipamento() async {
    final prefs = await SharedPreferences.getInstance();
    var jUsuario = prefs.getString("jUsuario");
    Map<String, dynamic> mapResponse = json.decode(jUsuario!);
    var usuario = Usuario.fromJson(mapResponse);
    var token = usuario.accessToken;

    var headers = {"Authorization": "Bearer $token"};
    var url = Uri.parse('https://tanilo.herokuapp.com/equipamentos');
    var response = await http.get(url, headers: headers);


    utf8.decode(response.bodyBytes);
    List listResponse = json.decode(utf8.decode(response.bodyBytes));
    final equipamento = <Equipamento>[];
    for (Map<String, dynamic> map in listResponse) {
      Equipamento p = Equipamento.fromJson(map);
      equipamento.add(p);
    }
    return equipamento;
  }
  static Future<Equipamento?> postEquipamento(
      nome, valorDaCompra, valorAluguelQuinzena, valorAluguelDia, valorAluguelMes) async {
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
    """{"nome": "$nome","valorDaCompra": "$valorDaCompra","valorAluguelQuinzena": "$valorAluguelQuinzena","valorAluguelDia": "$valorAluguelDia","valorAluguelMes": "$valorAluguelMes"}""";

    var url = Uri.parse('https://tanilo.herokuapp.com/equipamentos');
    var response = await http.post(url, headers: headers, body: body);
    utf8.decode(response.bodyBytes);
    Map<String, dynamic> idResponse =
    json.decode(utf8.decode(response.bodyBytes));
    var equipamento = Equipamento.fromJson(idResponse);
    return equipamento;
  }

  static Future<Equipamento?> putEquipamento(
      nome, id, valorDaCompra, valorAluguelQuinzena, valorAluguelDia, valorAluguelMes) async {
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
    """{"nome": "$nome","valorDaCompra": "$valorDaCompra","valorAluguelQuinzena": "$valorAluguelQuinzena","valorAluguelDia": "$valorAluguelDia","valorAluguelMes": "$valorAluguelMes"}""";

    print(body);
    var url = Uri.parse('https://tanilo.herokuapp.com/equipamentos/$id');
    print(id);
    var response = await http.put(url, headers: headers, body: body);
    print(response.statusCode);
    utf8.decode(response.bodyBytes);
    Map<String, dynamic> id2Response =
    json.decode(utf8.decode(response.bodyBytes));
    var equipamento = Equipamento.fromJson(id2Response);
    return equipamento;
  }

  static Future<Equipamento?> deleteEquipamento(id) async {
    final prefs = await SharedPreferences.getInstance();
    var jUsuario = prefs.getString("jUsuario");
    Map<String, dynamic> mapResponse = json.decode(jUsuario!);
    var usuario = Usuario.fromJson(mapResponse);
    var token = usuario.accessToken;

    var headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    };

    var url = Uri.parse('https://tanilo.herokuapp.com/equipamentos/$id');
    await http.delete(url, headers: headers);
    return null;


  }

}


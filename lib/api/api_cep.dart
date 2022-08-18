import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../domain/cep.dart';

class CepApi {
  static Future<Cep?> getCep(String getCep) async {
    var url = Uri.parse('https://viacep.com.br/ws/$getCep/json/');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      utf8.decode(response.bodyBytes);
      Map<String, dynamic> mapResponse =
          json.decode(utf8.decode(response.bodyBytes));
      var cep = Cep.fromJson(mapResponse);
      print(cep.localidade);
      return cep;
    } else {
      Get.snackbar(
          'CEP Incorreto', 'Digite o CEP de 8 digitos com apenas numeros',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}

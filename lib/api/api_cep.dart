import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../domain/cep.dart';

class CepApi {
  static Future<Cep?> getCep(String getCep) async {
    var url = Uri.parse('https://viacep.com.br/ws/$getCep/json/');
    var response = await http.get(url);


    print(response.statusCode);
    print(response.body);



   if (response.statusCode != 200 || response.body.contains("erro")) {
      Get.snackbar(
          'CEP Incorreto', 'Digite o CEP de 8 digitos com apenas numeros',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);}
    else {
      Map<String, dynamic> mapResponse =
      json.decode(response.body);
      var cep = Cep.fromJson(mapResponse);
      return cep;}


    }
  }


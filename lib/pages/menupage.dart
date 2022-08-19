// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tela_login_goga/domain/cores.dart';
import 'package:tela_login_goga/pages/alugueis.dart';
import 'package:tela_login_goga/pages/clientes.dart';
import 'package:tela_login_goga/pages/enderecos.dart';
import 'package:tela_login_goga/pages/homepage.dart';

import '../widget/logo.dart';
import 'equipamentos.dart';

class MenuPage extends StatelessWidget {
  MenuPage({Key? key}) : super(key: key);

  static logout() {
    Get.offAll(HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: useColor),
        backgroundColor: appbarColor,
        title: Text(
          'Base Equipamentos',
          style: TextStyle(
            color: useColor,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Logo(
                  height: 125,
                  width: 125,
                  image:
                      "https://media.discordapp.net/attachments/569592762765410334/1009997591976611960/image-removebg-preview_5.png"),
              SizedBox(
                height: 15,
              ),
              Container(
                width: 300,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: useColor,
                  ),
                  onPressed: () {
                    Get.to(() => AlugueisPage());
                  },
                  child: Text('Alugueis',
                      style: TextStyle(
                        color: backColor,
                        fontSize: 30,
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 300,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: useColor,
                  ),
                  onPressed: () {
                    Get.to(() => ClientesPage());
                  },
                  child: Text('Clientes',
                      style: TextStyle(
                        color: backColor,
                        fontSize: 30,
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 300,
                child: TextButton(
                  style: TextButton.styleFrom(backgroundColor: useColor),
                  onPressed: () {
                    Get.to(() => EquipamentosPage());
                  },
                  child: Text('Equipamentos',
                      style: TextStyle(
                        color: backColor,
                        fontSize: 30,
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 300,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: useColor,
                  ),
                  onPressed: () {
                    Get.to(() => EnderecosPage());
                  },
                  child: Text(
                    'Endereços',
                    style: TextStyle(
                      color: backColor,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

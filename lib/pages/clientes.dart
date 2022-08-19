// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tela_login_goga/domain/cores.dart';
import '../widget/logo.dart';
import 'menupage.dart';

class ClientesPage extends StatelessWidget {
  ClientesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: useColor),
        backgroundColor: appbarColor,
        title: Text(
          'Clientes',
          style: TextStyle(
            color: useColor,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await MenuPage.logout();
              }),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 12,
            ),
            const Logo(
                height: 125,
                width: 125,
                image:
                    "https://media.discordapp.net/attachments/569592762765410334/1009997591976611960/image-removebg-preview_5.png"),
            SizedBox(
              height: 15,
            ),
            Container(
              width: 250,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: useColor,
                ),
                onPressed: () async {},
                child: Text('Listar',
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
              width: 250,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: useColor,
                ),
                onPressed: () {},
                child: Text('Cadastrar',
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
              width: 250,
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: useColor),
                onPressed: () {},
                child: Text('Atualizar',
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
              width: 250,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: useColor,
                ),
                onPressed: () {},
                child: Text(
                  'Excluir',
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
    );
  }
}

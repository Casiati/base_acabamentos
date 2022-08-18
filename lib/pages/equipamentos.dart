// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'menupage.dart';

class EquipamentosPage extends StatelessWidget {
  EquipamentosPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(
          'Equipamentos',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: () async {
            await MenuPage.logout();
          }),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              width: 250,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.pink,
                ),
                onPressed: () {},
                child: Text('Listar',
                    style: TextStyle(
                      color: Colors.white,
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
                  backgroundColor: Colors.pink,
                ),
                onPressed: () {},
                child: Text('Cadastrar',
                    style: TextStyle(
                      color: Colors.white,
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
                style: TextButton.styleFrom(backgroundColor: Colors.pink),
                onPressed: () {},
                child: Text('Atualizar',
                    style: TextStyle(
                      color: Colors.white,
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
                  backgroundColor: Colors.pink,
                ),
                onPressed: () {},
                child: Text(
                  'Excluir',
                  style: TextStyle(
                    color: Colors.white,
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

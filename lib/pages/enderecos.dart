// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tela_login_goga/domain/endereco.dart';

import '../api/api_endereco.dart';
import 'menupage.dart';

class EnderecosPage extends StatefulWidget {
  EnderecosPage({Key? key}) : super(key: key);

  @override
  State<EnderecosPage> createState() => _EnderecosPage();
}

class _EnderecosPage extends State<EnderecosPage> {
  bool apareceLista = false;
  bool apareceCasd = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text(
            'Endereços',
            style: TextStyle(
              color: Colors.white,
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
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 250,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.orange,
                    ),
                    onPressed: () {
                      setState(() {
                        apareceLista = true;
                        apareceCasd = false;
                      });
                    },
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
                      backgroundColor: Colors.orange,
                    ),
                    onPressed: () {
                      setState(() {
                        apareceLista = false;
                        apareceCasd = true;
                      });
                    },
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
                    style: TextButton.styleFrom(backgroundColor: Colors.orange),
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
                      backgroundColor: Colors.orange,
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
                SizedBox(
                  height: 30,
                ),
                apareceLista ? listaEndereco() : SizedBox(),
                apareceCasd ? cadastraEnd() : SizedBox(),
              ],
            ),
          ),
        ));
  }

  listaEndereco() {
    Future<List<Endereco?>?> endereco = EnderecoApi.getEndereco();
    return FutureBuilder(
        future: endereco,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                  strokeWidth: 5.0,
                ),
              );
            default:
              if (snapshot.hasError) {
                return Container(
                  width: 250,
                  height: 50,
                  color: Colors.red,
                  alignment: Alignment.center,
                  child: Text(
                    'Falha na Requisão',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                );
              } else {
                List<Endereco>? endereco = snapshot.data as List<Endereco>?;
                return listView(endereco);
              }
          }
        });
  }

  listView(endereco) {
    return SingleChildScrollView(
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: endereco.length,
        itemBuilder: (context, index) {
          Endereco p = endereco[index];
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 340,
                  height: 40,
                  alignment: Alignment.centerLeft,
                  color: Colors.orange,
                  child: Text(
                    '  ID: ${p.id.toString()}',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Text(
                  'CEP: ${p.cep.toString()}',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  p.localidade.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  p.logradouro.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Nº: ${p.numero.toString()}',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  TextEditingController cep = TextEditingController();
  TextEditingController numero = TextEditingController();
  TextEditingController rua = TextEditingController();
  TextEditingController bairro = TextEditingController();
  TextEditingController localidade = TextEditingController();
  TextEditingController estado = TextEditingController();

  cadastraEnd() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 260,
                  child: TextField(
                    controller: cep,
                    decoration: InputDecoration(
                      labelText: 'CEP',
                      labelStyle: TextStyle(),
                    ),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Ink(
                  decoration: const ShapeDecoration(
                    color: Colors.orange,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                    ),
                    color: Colors.white,
                    splashColor: Colors.black,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  width: 220,
                  child: TextField(
                    controller: rua,
                    decoration: InputDecoration(
                      labelText: 'Rua',
                      labelStyle: TextStyle(),
                    ),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Container(
                  width: 100,
                  child: TextField(
                    controller: numero,
                    decoration: InputDecoration(
                      labelText: 'Numero',
                      labelStyle: TextStyle(),
                    ),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: 340,
              child: TextField(
                controller: bairro,
                decoration: InputDecoration(
                  labelText: 'Bairro',
                  labelStyle: TextStyle(),
                ),
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom:30),
              child: Row(
                children: [
                  Container(
                    width: 220,
                    child: TextField(
                      controller: localidade,
                      decoration: InputDecoration(
                        labelText: 'Cidade',
                        labelStyle: TextStyle(),
                      ),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    child: TextField(
                      controller: estado,
                      decoration: InputDecoration(
                        labelText: 'Estado',
                        labelStyle: TextStyle(),
                      ),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tela_login_goga/domain/endereco.dart';

import '../api/api_cep.dart';
import '../api/api_endereco.dart';
import '../domain/cep.dart';
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

  TextEditingController cepController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController ruaController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController localidadeController = TextEditingController();
  TextEditingController estadoController = TextEditingController();

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
                    keyboardType: TextInputType.number,
                    controller: cepController,
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
                    onPressed: () async {
                      var cep = await CepApi.getCep(cepController.text);
                      ruaController.text = cep!.logradouro!;
                      bairroController.text = cep.bairro!;
                      localidadeController.text = cep.localidade!;
                      estadoController.text = cep.uf!;
                    },
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
                    controller: ruaController,
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
                    controller: numeroController,
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
                controller: bairroController,
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
              padding: const EdgeInsets.only(bottom: 5),
              child: Row(
                children: [
                  Container(
                    width: 220,
                    child: TextField(
                      controller: localidadeController,
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
                      controller: estadoController,
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
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 30,
                  ),
                  SizedBox(
                      width: 120,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.orange),

                        onPressed: () {
                          cepController.text = "";
                          numeroController.text = "";
                          ruaController.text = "";
                          bairroController.text = "";
                          localidadeController.text = "";
                          estadoController.text = "";
                        },
                        child: Text(
                          'Limpar',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      )),
                  SizedBox(
                    width: 30,
                  ),
                  SizedBox(
                    width: 120,
                    child: TextButton(
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.orange),
                      onPressed: () {},
                      child: Text(
                        'Cadastrar',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

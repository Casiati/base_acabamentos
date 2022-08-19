// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../api/api_cep.dart';
import '../api/api_endereco.dart';
import '../widget/widget_endereco_page.dart';
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
                SizedBox(
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
                SizedBox(
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
                SizedBox(
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
                SizedBox(
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
  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Deseja confirmar o cadastro do endereço?",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text("${ruaController.text} ${numeroController.text}"),
          Text(bairroController.text),
          Text(cepController.text),
          Text("${localidadeController.text} - ${estadoController.text}"),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      width: 100,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.orange),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancelar',
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                      )),
                  SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: 100,
                    child: TextButton(
                      style:
                      TextButton.styleFrom(backgroundColor: Colors.orange),
                      onPressed: () async {
                        var endereco = await EnderecoApi.postEndereco(
                            bairroController.text,
                            cepController.text,
                            localidadeController.text,
                            ruaController.text,
                            numeroController.text,
                            estadoController.text);
                        Navigator.pop(context);

                        if (endereco!.id != null) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Sucesso'),
                              content: Text(
                                  'Adicionou endereço com ID:${endereco.id}'),
                              actions: <Widget>[
                                TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.orange),
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text(
                                    'Ok',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Confirmar',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  cadastraEnd() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
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
                SizedBox(
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
                SizedBox(
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
            SizedBox(
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
                  SizedBox(
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
                  SizedBox(
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
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.orange),
                        onPressed: () {
                          var enderecos = EnderecosPage;
                          showLoaderDialog(context);

                        },
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
              ),
            )
          ],
        ),
      ),
    );
  }
}

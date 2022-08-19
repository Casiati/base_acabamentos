// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tela_login_goga/domain/cores.dart';
import '../api/api_cep.dart';
import '../api/api_endereco.dart';
import '../widget/logo.dart';
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
        backgroundColor: backColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: useColor),
          backgroundColor: appbarColor,
          title: Text(
            'Endereços',
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
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
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
                SizedBox(
                  width: 250,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: useColor,
                    ),
                    onPressed: () {
                      setState(() {
                        apareceLista = true;
                        apareceCasd = false;
                      });
                    },
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
                SizedBox(
                  width: 250,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: useColor,
                    ),
                    onPressed: () {
                      setState(() {
                        apareceLista = false;
                        apareceCasd = true;
                      });
                    },
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
                SizedBox(
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
                SizedBox(
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
      backgroundColor: backColor,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Deseja confirmar o cadastro do endereço?",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: useColor,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "${ruaController.text} ${numeroController.text}",
            style: TextStyle(color: useColor),
          ),
          Text(
            bairroController.text,
            style: TextStyle(color: useColor),
          ),
          Text(
            cepController.text,
            style: TextStyle(color: useColor),
          ),
          Text(
            "${localidadeController.text} - ${estadoController.text}",
            style: TextStyle(color: useColor),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      width: 100,
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: useColor),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancelar',
                          style: TextStyle(
                            fontSize: 17,
                            color: backColor,
                          ),
                        ),
                      )),
                  SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: 100,
                    child: TextButton(
                      style: TextButton.styleFrom(backgroundColor: useColor),
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
                              backgroundColor: backColor,
                              title: Text(
                                'Sucesso',
                                style: TextStyle(color: useColor),
                              ),
                              content: Text(
                                'Adicionou endereço com ID:${endereco.id}',
                                style: TextStyle(color: useColor),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: useColor),
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    'Ok',
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: backColor,
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
                          color: backColor,
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
                    cursorColor: useColor,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(),
                      labelStyle: TextStyle(color: useColor),
                      labelText: 'CEP',
                    ),
                    style: TextStyle(
                      fontSize: 18,
                      color: useColor,
                    ),
                  ),
                ),
                Ink(
                  decoration: ShapeDecoration(
                    color: useColor,
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
                    color: backColor,
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
                    cursorColor: useColor,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(),
                      labelStyle: TextStyle(color: useColor),
                      labelText: 'Rua',
                    ),
                    style: TextStyle(
                      fontSize: 18,
                      color: useColor,
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
                    cursorColor: useColor,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(),
                      labelStyle: TextStyle(color: useColor),
                      labelText: 'Numero',
                    ),
                    style: TextStyle(
                      fontSize: 18,
                      color: useColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 340,
              child: TextField(
                controller: bairroController,
                cursorColor: useColor,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(),
                  labelStyle: TextStyle(color: useColor),
                  labelText: 'Bairro',
                ),
                style: TextStyle(
                  fontSize: 18,
                  color: useColor,
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
                      cursorColor: useColor,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(),
                        labelStyle: TextStyle(color: useColor),
                        labelText: 'Cidade',
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        color: useColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: TextField(
                      controller: estadoController,
                      cursorColor: useColor,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(),
                        labelStyle: TextStyle(color: useColor),
                        labelText: 'Estado',
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        color: useColor,
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
                          style:
                              TextButton.styleFrom(backgroundColor: useColor),
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
                              color: backColor,
                            ),
                          ),
                        )),
                    SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      width: 120,
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: useColor),
                        onPressed: () {
                          var enderecos = EnderecosPage;
                          showLoaderDialog(context);
                        },
                        child: Text(
                          'Cadastrar',
                          style: TextStyle(
                            fontSize: 20,
                            color: backColor,
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

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../api/api_cep.dart';
import '../api/api_endereco.dart';
import '../domain/cores.dart';
import '../domain/endereco.dart';
import 'package:tela_login_goga/pages/enderecos.dart';

int? iD;
List<Endereco> endereco = [];
bool isSorted = false;


cadastraEnd(BuildContext context, botao) {
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
                    if (cep != null) {
                      ruaController.text = cep.logradouro!;
                      bairroController.text = cep.bairro!;
                      localidadeController.text = cep.localidade!;
                      estadoController.text = cep.uf!;
                    }
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
                        if (cepController.text == "" &&
                            numeroController.text == "" &&
                            ruaController.text == "" &&
                            bairroController.text == "" &&
                            localidadeController.text == "" &&
                            estadoController.text == "") {
                          Get.snackbar('Campo em branco',
                              'Preencha todos os campos para poder adicionar',
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM);
                        } else {
                          showLoaderDialog(context, botao);
                        }
                      },
                      child: Text(
                        'Confirmar',
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
showLoaderDialog(BuildContext context, botao) {
  AlertDialog alert = AlertDialog(
    backgroundColor: backColor,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (botao == 1)
          Text(
            "Deseja cadastrar o este endereço?",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: useColor,
            ),
          )
        else
          Text(
            "Deseja atualizar o este endereço?",
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
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                if (botao == 1)
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
                        'Cadastrar',
                        style: TextStyle(
                          fontSize: 17,
                          color: backColor,
                        ),
                      ),
                    ),
                  )
                else
                  SizedBox(
                    width: 100,
                    child: TextButton(
                      style: TextButton.styleFrom(backgroundColor: useColor),
                      onPressed: () async {
                        print(iD);
                        var endereco = await EnderecoApi.putEndereco(
                            bairroController.text,
                            cepController.text,
                            iD,
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
                                'Atualizou endereço com ID:${endereco.id}',
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
                        'Atualizar',
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

listaEndereco(apcLista, apcCadas, apcAtual(p), atualLista) {
  Future<List<Endereco?>?> endereco = EnderecoApi.getEndereco();
  return FutureBuilder(
      future: endereco,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
          case ConnectionState.none:
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(useColor),
                strokeWidth: 5.0,
              ),
            );
          default:
            if (snapshot.hasError) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.red,
                ),
                width: 250,
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  'Falha na Requisão',
                  style: TextStyle(
                    fontSize: 25,
                    color: backColor,
                  ),
                ),
              );
            } else {
              List<Endereco>? endereco = snapshot.data as List<Endereco>?;
              return listView(
                  endereco, apcLista, apcCadas, apcAtual, atualLista);
            }
        }
      });
}

sort() {
  if (!isSorted) {
    endereco.sort((Endereco b, Endereco a) => a.id!.compareTo(b.id!));
    isSorted = true;

  } else {endereco = endereco.reversed.toList();
  }
}

listView(endereco, apcLista, apcCadas, apcAtual(p), atualLista) {
  return SingleChildScrollView(
    child: ListView.builder(
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: endereco.length,
      itemBuilder: (context, index) {
        endereco.sort((Endereco b, Endereco a) => a.id!.compareTo(b.id!));
        Endereco p = endereco[index];
        return Slidable(
          actionExtentRatio: 0.25,
          actionPane: const SlidableDrawerDismissal(),
          actions: [
            IconSlideAction(
              foregroundColor: Colors.blueAccent,
              color: backColor,
              icon: Icons.edit,
              onTap: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    backgroundColor: backColor,
                    title: Text(
                      'Deseja EDITAR este endereço?',
                      style: TextStyle(color: useColor),
                    ),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text(
                            "ID:${p.id}",
                            style: TextStyle(color: useColor),
                          ),
                          Text(
                            '${p.logradouro} Nº${p.numero}',
                            style: TextStyle(color: useColor),
                          ),
                          Text(
                            '${p.bairro}',
                            style: TextStyle(color: useColor),
                          ),
                          Text(
                            '${p.cep}',
                            style: TextStyle(color: useColor),
                          ),
                          Text(
                            '${p.localidade} - ${p.uf}',
                            style: TextStyle(color: useColor),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 100,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: useColor),
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
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            SizedBox(
                              width: 100,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: useColor),
                                onPressed: () {
                                  apcAtual(p);
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
                    ],
                  ),
                );
              },
              caption: 'Editar',
            )
          ],
          secondaryActions: [
            IconSlideAction(
              foregroundColor: Colors.redAccent,
              color: backColor,
              icon: Icons.delete_outline,
              onTap: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    backgroundColor: backColor,
                    title: Text(
                      'Deseja DELETAR este endereço?',
                      style: TextStyle(color: useColor),
                    ),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text(
                            "ID:${p.id}",
                            style: TextStyle(color: useColor),
                          ),
                          Text(
                            '${p.logradouro} Nº${p.numero}',
                            style: TextStyle(color: useColor),
                          ),
                          Text(
                            '${p.bairro}',
                            style: TextStyle(color: useColor),
                          ),
                          Text(
                            '${p.cep}',
                            style: TextStyle(color: useColor),
                          ),
                          Text(
                            '${p.localidade} - ${p.uf}',
                            style: TextStyle(color: useColor),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 100,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: useColor),
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
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            SizedBox(
                              width: 100,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: useColor),
                                onPressed: () {
                                  var endereco =
                                  EnderecoApi.deleteEndereco(p.id);
                                  Navigator.pop(context);
                                  print(p.id);
                                  if (p.id != null) {
                                    showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            backgroundColor: backColor,
                                            title: Text(
                                              'Sucesso',
                                              style: TextStyle(color: useColor),
                                            ),
                                            content: Text(
                                              'Deletou endereço com ID:${p.id}',
                                              style: TextStyle(color: useColor),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                    backgroundColor: useColor),
                                                onPressed: atualLista,
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
                                  ;
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
                    ],
                  ),
                );
              },
              caption: 'Deletar',
            )
          ],
          child: Card(
            color: appbarColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: useColor,
                    ),
                    width: 340,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '  ID: ${p.id.toString()}',
                      style: TextStyle(fontSize: 20, color: backColor),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'CEP: ${p.cep.toString()}',
                    style: TextStyle(fontSize: 20, color: useColor),
                  ),
                  Text(
                    p.localidade.toString(),
                    style: TextStyle(fontSize: 20, color: useColor),
                  ),
                  Text(
                    p.logradouro.toString(),
                    style: TextStyle(fontSize: 20, color: useColor),
                  ),
                  Text(
                    'Nº: ${p.numero.toString()}',
                    style: TextStyle(fontSize: 20, color: useColor),
                  ),
                ],
              ),
            ),
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
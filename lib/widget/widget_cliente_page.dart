import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../api/api_cliente.dart';
import '../domain/cores.dart';
import '../domain/cliente.dart';

int? iD;
List<Cliente> cliente = [];
bool isSorted = false;

cadastraEnd(BuildContext context, botao, atualLista) {
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
                  controller: idEnderecoController,
                  cursorColor: useColor,
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(),
                    labelStyle: TextStyle(color: useColor),
                    labelText: 'CEP',
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    color: useColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 220,
                child: TextField(
                  controller: nomeController,
                  cursorColor: useColor,
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(),
                    labelStyle: TextStyle(color: useColor),
                    labelText: 'Rua',
                  ),
                  style: TextStyle(
                    fontSize: 18,
                    color: useColor,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              SizedBox(
                width: 100,
                child: TextField(
                  controller: telefone1Controller,
                  cursorColor: useColor,
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(),
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
              controller: telefone2Controller,
              cursorColor: useColor,
              decoration: InputDecoration(
                focusedBorder: const UnderlineInputBorder(),
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
            padding: const EdgeInsets.only(bottom: 10),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      width: 120,
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: useColor),
                        onPressed: () {
                          idEnderecoController.text = "";
                          telefone1Controller.text = "";
                          nomeController.text = "";
                          telefone2Controller.text = "";
                        },
                        child: Text(
                          'Limpar',
                          style: TextStyle(
                            fontSize: 20,
                            color: backColor,
                          ),
                        ),
                      )),
                  const SizedBox(
                    width: 30,
                  ),
                  SizedBox(
                    width: 120,
                    child: TextButton(
                      style: TextButton.styleFrom(backgroundColor: useColor),
                      onPressed: () {
                        if (idEnderecoController.text == "" ||
                            telefone1Controller.text == "" ||
                            nomeController.text == "" ||
                            telefone2Controller.text == "") {
                          Get.snackbar('Campo em branco',
                              'Preencha todos os campos para poder adicionar',
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM);
                        } else {
                          showLoaderDialog(context, botao, atualLista);
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

showLoaderDialog(BuildContext context, botao, atualLista) {
  AlertDialog alert = AlertDialog(
    backgroundColor: backColor,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (botao == 1)
          Text(
            "Deseja cadastrar este endereço?",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: useColor,
            ),
          )
        else
          Text(
            "Deseja atualizar este endereço?",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: useColor,
            ),
          ),
        const SizedBox(
          height: 15,
        ),
        Text(
          "${nomeController.text} ${telefone1Controller.text}",
          style: TextStyle(color: useColor),
        ),
        Text(
          telefone2Controller.text,
          style: TextStyle(color: useColor),
        ),
        Text(
          idEnderecoController.text,
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
                const SizedBox(
                  width: 15,
                ),
                if (botao == 1)
                  SizedBox(
                    width: 100,
                    child: TextButton(
                      style: TextButton.styleFrom(backgroundColor: useColor),
                      onPressed: () async {
                        var cliente = await ClienteApi.postCliente(
                          nomeController.text,
                          iD,
                          cpfCnpjController.text,
                          telefone1Controller.text,
                          telefone2Controller.text,
                          idEnderecoController.text,
                        );
                        Navigator.pop(context);

                        if (cliente!.id != null) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              backgroundColor: backColor,
                              title: Text(
                                'Sucesso',
                                style: TextStyle(color: useColor),
                              ),
                              content: Text(
                                'Adicionou endereço com ID:${cliente.id}',
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
                        var cliente = await ClienteApi.putCliente(
                          nomeController.text,
                          iD,
                          cpfCnpjController.text,
                          telefone1Controller.text,
                          telefone2Controller.text,
                          idEnderecoController.text,
                        );
                        Navigator.pop(context);

                        if (cliente!.id != null) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              backgroundColor: backColor,
                              title: Text(
                                'Sucesso',
                                style: TextStyle(color: useColor),
                              ),
                              content: Text(
                                'Atualizou endereço com ID:${cliente.id}',
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

listaCliente(apcLista, apcCadas, apcAtual(p), atualLista) {
  Future<List<Cliente?>?> cliente = ClienteApi.getCliente();
  return FutureBuilder(
      future: cliente,
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
                  'Falha na Requisisão',
                  style: TextStyle(
                    fontSize: 25,
                    color: backColor,
                  ),
                ),
              );
            } else {
              List<Cliente>? cliente = snapshot.data as List<Cliente>?;
              return listView(
                  cliente, apcLista, apcCadas, apcAtual, atualLista);
            }
        }
      });
}

sort() {
  if (!isSorted) {
    cliente.sort((Cliente b, Cliente a) => a.id!.compareTo(b.id!));
    isSorted = true;
  } else {
    cliente = cliente.reversed.toList();
  }
}

listView(cliente, apcLista, apcCadas, apcAtual(p), atualLista) {
  return SingleChildScrollView(
    child: ListView.builder(
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: cliente.length,
      itemBuilder: (context, index) {
        cliente.sort((Cliente b, Cliente a) => a.id!.compareTo(b.id!));
        Cliente p = cliente[index];
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
                            '${p.nome} Nº${p.telefone1}',
                            style: TextStyle(color: useColor),
                          ),
                          Text(
                            '${p.telefone2}',
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
                            const SizedBox(
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
                            '${p.nome} Nº${p.telefone1}',
                            style: TextStyle(color: useColor),
                          ),
                          Text(
                            '${p.telefone2}',
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
                            const SizedBox(
                              width: 15,
                            ),
                            SizedBox(
                              width: 100,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: useColor),
                                onPressed: () async {
                                  await ClienteApi.deleteCliente(p.id);
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
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    p.nome.toString(),
                    style: TextStyle(fontSize: 20, color: useColor),
                  ),
                  Text(
                    'Nº: ${p.telefone1.toString()}',
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

TextEditingController idEnderecoController = TextEditingController();
TextEditingController nomeController = TextEditingController();
TextEditingController telefone1Controller = TextEditingController();
TextEditingController telefone2Controller = TextEditingController();
TextEditingController cpfCnpjController = TextEditingController();

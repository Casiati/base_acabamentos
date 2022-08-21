import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../api/api_equipamento.dart';
import '../domain/cores.dart';
import '../domain/equipamento.dart';

int? iD;
List<Equipamento> equipamento = [];
bool isSorted = false;

cadastraEnd(BuildContext context, botao, atualLista) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              width: 330,
              child: TextField(
                controller: nomeController,
                cursorColor: useColor,
                decoration: InputDecoration(
                  focusedBorder: const UnderlineInputBorder(),
                  labelStyle: TextStyle(color: useColor, fontSize: 14),
                  labelText: 'Nome',
                ),
                style: TextStyle(
                  fontSize: 18,
                  color: useColor,
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 150,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: valorDaCompraController,
                    cursorColor: useColor,
                    decoration: InputDecoration(
                      focusedBorder: const UnderlineInputBorder(),
                      labelStyle: TextStyle(color: useColor, fontSize: 14),
                      labelText: 'Compra',
                      prefixText: 'R\$ ',
                      prefixStyle: TextStyle(
                        fontSize: 18,
                        color: useColor,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 18,
                      color: useColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 19,
                ),
                SizedBox(
                  width: 150,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: valorAluguelDiaController,
                    cursorColor: useColor,
                    decoration: InputDecoration(
                      focusedBorder: const UnderlineInputBorder(),
                      labelStyle: TextStyle(color: useColor, fontSize: 14),
                      labelText: 'Aluguel Dia',
                      prefixText: 'R\$ ',
                      prefixStyle: TextStyle(
                        fontSize: 18,
                        color: useColor,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 18,
                      color: useColor,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: valorAluguelQuinzenaController,
                      cursorColor: useColor,
                      decoration: InputDecoration(
                        focusedBorder: const UnderlineInputBorder(),
                        labelStyle: TextStyle(color: useColor, fontSize: 14),
                        labelText: 'Aluguel Quinzena',
                        prefixText: 'R\$ ',
                        prefixStyle: TextStyle(
                          fontSize: 18,
                          color: useColor,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        color: useColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 19,
                  ),
                  SizedBox(
                    width: 150,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: valorAluguelMesController,
                      cursorColor: useColor,
                      decoration: InputDecoration(
                        focusedBorder: const UnderlineInputBorder(),
                        labelStyle: TextStyle(color: useColor, fontSize: 14),
                        labelText: 'Aluguel Mes',
                        prefixText: 'R\$ ',
                        prefixStyle: TextStyle(
                          fontSize: 18,
                          color: useColor,
                        ),
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
              padding: const EdgeInsets.only(bottom: 10),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                        width: 119,
                        child: TextButton(
                          style:
                              TextButton.styleFrom(backgroundColor: useColor),
                          onPressed: () {
                            nomeController.text = "";
                            valorDaCompraController.text = "";
                            valorAluguelDiaController.text = "";
                            valorAluguelQuinzenaController.text = "";
                            valorAluguelMesController.text = "";
                          },
                          child: Text(
                            'Limpar',
                            style: TextStyle(
                              fontSize: 19,
                              color: backColor,
                            ),
                          ),
                        )),
                    const SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      width: 119,
                      child: TextButton(
                        style: TextButton.styleFrom(backgroundColor: useColor),
                        onPressed: () {
                          if (nomeController.text == "" ||
                              valorDaCompraController.text == "" ||
                              valorAluguelDiaController.text == "" ||
                              valorAluguelQuinzenaController.text == "" ||
                              valorAluguelMesController.text == "") {
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
                            fontSize: 19,
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
            "Deseja cadastrar este Equipamento?",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w500,
              color: useColor,
            ),
          )
        else
          Text(
            "Deseja atualizar este Equipamento?",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w500,
              color: useColor,
            ),
          ),
        const SizedBox(
          height: 15,
        ),
        Text(
          nomeController.text,
          style: TextStyle(color: useColor),
        ),
        Text(
          "Compra: R\$${valorDaCompraController.text}",
          style: TextStyle(color: useColor),
        ),
        Text(
          'Aluguel dia: R\$${valorAluguelDiaController.text}',
          style: TextStyle(color: useColor),
        ),
        Text(
          'Aluguel Quinzena: R\$${valorAluguelQuinzenaController.text}',
          style: TextStyle(color: useColor),
        ),
        Text(
          'Aluguel Mês: R\$${valorAluguelMesController.text}',
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
                        var equipamento = await EquipamentoApi.postEquipamento(
                            nomeController.text.replaceAll(",", "."),
                            valorDaCompraController.text.replaceAll(",", "."),
                            valorAluguelQuinzenaController.text
                                .replaceAll(",", "."),
                            valorAluguelDiaController.text.replaceAll(",", "."),
                            valorAluguelMesController.text
                                .replaceAll(",", "."));
                        Navigator.pop(context);

                        if (equipamento!.id != null) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              backgroundColor: backColor,
                              title: Text(
                                'Sucesso',
                                style: TextStyle(color: useColor),
                              ),
                              content: Text(
                                'Adicionou equipamento com ID:${equipamento.id}',
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
                        var equipamento = await EquipamentoApi.putEquipamento(
                            nomeController.text.replaceAll(",", "."),
                            iD,
                            valorDaCompraController.text.replaceAll(",", "."),
                            valorAluguelQuinzenaController.text
                                .replaceAll(",", "."),
                            valorAluguelDiaController.text.replaceAll(",", "."),
                            valorAluguelMesController.text
                                .replaceAll(",", "."));
                        Navigator.pop(context);

                        if (equipamento!.id != null) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              backgroundColor: backColor,
                              title: Text(
                                'Sucesso',
                                style: TextStyle(color: useColor),
                              ),
                              content: Text(
                                'Atualizou equipamento com ID:${equipamento.id}',
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

listaEquipamento(apcLista, apcCadas, apcAtual(p), atualLista) {
  Future<List<Equipamento?>?> equipamento = EquipamentoApi.getEquipamento();
  return FutureBuilder(
      future: equipamento,
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
              List<Equipamento>? equipamento =
                  snapshot.data as List<Equipamento>?;
              return listView(
                  equipamento, apcLista, apcCadas, apcAtual, atualLista);
            }
        }
      });
}

sort() {
  if (!isSorted) {
    equipamento.sort((Equipamento b, Equipamento a) => a.id!.compareTo(b.id!));
    isSorted = true;
  } else {
    equipamento = equipamento.reversed.toList();
  }
}

listView(equipamento, apcLista, apcCadas, apcAtual(p), atualLista) {
  return SingleChildScrollView(
    child: ListView.builder(
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: equipamento.length,
      itemBuilder: (context, index) {
        equipamento
            .sort((Equipamento b, Equipamento a) => a.id!.compareTo(b.id!));
        Equipamento p = equipamento[index];
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
                      'Deseja EDITAR este equipamento?',
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
                            '${p.nome}',
                            style: TextStyle(color: useColor),
                          ),
                          Text(
                            "Compra: R\$${p.valorDaCompra!.toStringAsFixed(2).replaceAll('.', ',')}",
                            style: TextStyle(color: useColor),
                          ),
                          Text(
                            'Aluguel dia: R\$${p.valorAluguelDia!.toStringAsFixed(2).replaceAll('.', ',')}',
                            style: TextStyle(color: useColor),
                          ),
                          Text(
                            'Aluguel Quinzena: R\$${p.valorAluguelQuinzena!.toStringAsFixed(2).replaceAll('.', ',')}',
                            style: TextStyle(color: useColor),
                          ),
                          Text(
                            'Aluguel Mês: R\$${p.valorAluguelMes!.toStringAsFixed(2).replaceAll('.', ',')}',
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
                                onPressed: () => apcAtual(p),
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
                      'Deseja DELETAR este equipamento?',
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
                            '${p.nome}',
                            style: TextStyle(color: useColor),
                          ),
                          Text(
                            "Compra: R\$${p.valorDaCompra!.toStringAsFixed(2).replaceAll('.', ',')}",
                            style: TextStyle(color: useColor),
                          ),
                          Text(
                            'Aluguel dia: R\$${p.valorAluguelDia!.toStringAsFixed(2).replaceAll('.', ',')}',
                            style: TextStyle(color: useColor),
                          ),
                          Text(
                            'Aluguel Quinzena: R\$${p.valorAluguelQuinzena!.toStringAsFixed(2).replaceAll('.', ',')}',
                            style: TextStyle(color: useColor),
                          ),
                          Text(
                            'Aluguel Mês: R\$${p.valorAluguelMes!.toStringAsFixed(2).replaceAll('.', ',')}',
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
                                  await EquipamentoApi.deleteEquipamento(p.id);
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
                                          'Deletou Equipamento com ID:${p.id}',
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
              padding: const EdgeInsets.all(10.0),
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
                      style: TextStyle(
                          fontSize: 19,
                          color: backColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      p.nome.toString(),
                      style: TextStyle(
                          fontSize: 23,
                          color: useColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          'Compra:',
                          style: TextStyle(
                              fontSize: 19,
                              color: useColor,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          " R\$${(p.valorDaCompra!.toStringAsFixed(2).replaceAll('.', ','))}",
                          style: TextStyle(fontSize: 19, color: useColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          'Aluguel Dia:',
                          style: TextStyle(
                              fontSize: 19,
                              color: useColor,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          " R\$${(p.valorAluguelDia!.toStringAsFixed(2).replaceAll('.', ','))}",
                          style: TextStyle(fontSize: 19, color: useColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          'Aluguel Quinzena:',
                          style: TextStyle(
                              fontSize: 19,
                              color: useColor,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          ' R\$${(p.valorAluguelQuinzena!.toStringAsFixed(2).replaceAll('.', ','))}',
                          style: TextStyle(fontSize: 19, color: useColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Text(
                          'Aluguel Mês:',
                          style: TextStyle(
                              fontSize: 19,
                              color: useColor,
                              fontWeight: FontWeight.w600),
                        ),
                        Container(
                          child: Text(
                            ' R\$${(p.valorAluguelMes!.toStringAsFixed(2).replaceAll('.', ','))}',
                            style: TextStyle(fontSize: 19, color: useColor),
                          ),
                        ),
                      ],
                    ),
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

TextEditingController nomeController = TextEditingController();
TextEditingController valorDaCompraController = TextEditingController();
TextEditingController valorAluguelDiaController = TextEditingController();
TextEditingController valorAluguelQuinzenaController = TextEditingController();
TextEditingController valorAluguelMesController = TextEditingController();

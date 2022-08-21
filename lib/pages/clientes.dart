import 'package:flutter/material.dart';
import 'package:tela_login_goga/domain/cores.dart';
import '../widget/logo.dart';
import '../widget/widget_cliente_page.dart';
import 'menupage.dart';

class ClientesPage extends StatefulWidget {
  ClientesPage({Key? key}) : super(key: key);

  @override
  State<ClientesPage> createState() => _ClientesPage();
}

class _ClientesPage extends State<ClientesPage> {
  bool apareceListaStatus = false;
  bool apareceCadasStatus = false;
  bool apareceAtualStatus = false;


  void apcLista() {
    setState(() {
      apareceListaStatus = true;
      apareceCadasStatus = false;
      apareceAtualStatus = false;
    });
  }

  void atualLista() {
    setState(() {
      apareceListaStatus = false;
      apareceCadasStatus = false;
      apareceAtualStatus = false;
      Navigator.pop(context);
    });
  }

  void apcCadas() {
    setState(() {
      apareceListaStatus = false;
      apareceCadasStatus = true;
      apareceAtualStatus = false;
      idEnderecoController.text = "";
      nomeController.text = "";
      telefone1Controller.text = "";
      telefone2Controller.text = "";
    });
  }

  void apcAtual(p) {
    setState(() {
      apareceListaStatus = false;
      apareceCadasStatus = false;
      apareceAtualStatus = true;
      Navigator.pop(context);
      idEnderecoController.text = p.endereco.id;
      nomeController.text = p.nome;
      telefone1Controller.text = p.telefone1;
      telefone2Controller.text = p.telefone2;
      cpfCnpjController.text = p.cpfCnpj;
      iD = p.id;
    });
  }

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
                    onPressed: apcLista,
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
                    onPressed: apcCadas,
                    child: Text('Cadastrar',
                        style: TextStyle(
                          color: backColor,
                          fontSize: 30,
                        )),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                (apareceListaStatus)
                    ? listaCliente(apcCadas, apcLista, apcAtual, atualLista)
                    : SizedBox(),
                (apareceCadasStatus) ? cadastraEnd(context, 1, atualLista) : SizedBox(),
                (apareceAtualStatus) ? cadastraEnd(context, 2, atualLista) : SizedBox(),
              ],
            ),
          ),
        ));
  }


}


import 'package:flutter/material.dart';
import '../api/api_cep.dart';
import '../api/api_endereco.dart';
import '../domain/endereco.dart';
import 'package:tela_login_goga/pages/enderecos.dart';



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
              return listView(endereco, Colors.orange);
            }
        }
      });
}

listView(endereco, cor) {
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
                color: cor,
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



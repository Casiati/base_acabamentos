// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController longinController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void login() {
    print(longinController.text + senhaController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Base Equipamentos',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.network(
                    "https://media.discordapp.net/attachments/569592762765410334/1007739284775784468/image-removebg-preview_4.png"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                  controller: longinController,
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Insira seu Email";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    labelStyle: TextStyle(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                  controller: senhaController,
                  validator: (value) {
                    if(value!.isEmpty){
                      return "Insira sua senha";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()){
                      login();
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

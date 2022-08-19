import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tela_login_goga/pages/menupage.dart';
import '../api/api_login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int estadoLogin = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text(
          'Base Equipamentos',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                  height: 125,
                  width: 125,
                  "https://media.discordapp.net/attachments/569592762765410334/1009997591976611960/image-removebg-preview_5.png"),
              SizedBox(
                height: 15,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(),
                  prefixIcon: Icon(Icons.mail),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                style: const TextStyle(
                  fontSize: 18,
                ),
                controller: userController,
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(),
                  prefixIcon: Icon(Icons.lock),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                style: const TextStyle(
                  fontSize: 18,
                ),
                controller: passwordController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: SizedBox(
                  width: 120,
                  child: TextButton(
                    onPressed: () async {
                      showLoaderDialog(context);
                      var usuario = await LoginApi.login(
                          userController.text, passwordController.text);
                      Navigator.pop(context);
                      if (usuario?.accessToken == null) {
                        Get.snackbar(
                          'Falha',
                          'Email ou Senha incorreto.',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.TOP,
                        );
                      }
                      if (usuario?.accessToken != null)
                        return Get.off(() => MenuPage());
                    },
                    style: TextButton.styleFrom(backgroundColor: Colors.amber),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
            margin: const EdgeInsets.only(left: 30),
            child: const Text(
              "Aguarde...",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
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
}

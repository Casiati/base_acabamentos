import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tela_login_goga/domain/cores.dart';
import 'package:tela_login_goga/pages/menupage.dart';
import 'package:tela_login_goga/widget/logo.dart';
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
      backgroundColor: backColor,
      appBar: AppBar(
        backgroundColor: appbarColor,
        title: Text(
          'Base Acabamentos',
          style: TextStyle(
            color: useColor,
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
              const Logo(
                  height: 170,
                  width: 170,
                  image:
                      "https://media.discordapp.net/attachments/569592762765410334/1009997591976611960/image-removebg-preview_5.png"),
              SizedBox(
                height: 15,
              ),
              TextField(
                cursorColor: useColor,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    color: useColor,
                  ),
                  prefixIcon: Icon(
                    Icons.mail,
                    color: useColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                style: TextStyle(
                  fontSize: 18,
                  color: useColor,
                ),
                controller: userController,
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                cursorColor: useColor,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Senha',
                  hintStyle: TextStyle(
                    color: useColor,
                  ),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: useColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                style: TextStyle(
                  fontSize: 18,
                  color: useColor,
                ),
                controller: passwordController,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
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
                        colorText: appbarColor,
                        snackPosition: SnackPosition.TOP,
                      );
                    }
                    if (usuario?.accessToken != null)
                      return Get.off(() => MenuPage());
                  },
                  style: TextButton.styleFrom(backgroundColor: useColor),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 25,
                        color: backColor,
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
    AlertDialog alert = AlertDialog(backgroundColor: backColor,
      content: Row(
        children: [
          CircularProgressIndicator(
            color: useColor,
          ),
          Container(
            margin: const EdgeInsets.only(left: 30),
            child: Text(
              "Aguarde...",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: useColor,
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

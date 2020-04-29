import 'package:coronapp/pages/RegisterPage.dart';
import 'package:coronapp/pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:coronapp/helpers/database_helper.dart';
import 'package:coronapp/models/user.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  TextStyle style = TextStyle(fontSize: 20);
  AnimationController _controller;
  final Tween<double> turnsTween = Tween<double>(begin: 1, end: 5);
  String _usuario = "";
  String _senha = "";

  final frmLoginKey = new GlobalKey<FormState>(); //identificador do formulário
  var db = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
  }

  _validarLogin() async {
    //capturando o estado atual do formulário
    final form = frmLoginKey.currentState;

    if (form.validate()) {
      form.save();

      User user = await db.validateLogin(_usuario, _senha);

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              user: user,
            ),
          ),
        );
      } else {
        _controller.forward();
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Opss! Algo deu errado.'),
              content: Text('Usuário ou senha inválidos'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final usuarioField = TextFormField(
      obscureText: false,
      style: style,
      onSaved: (valor) => _usuario = valor,
      validator: (valor) {
        return valor.length < 6
            ? "Usuário deve haver pelo menos 6 caracteres"
            : null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Usuário',
      ),
    );
    final senhaField = TextFormField(
      obscureText: true,
      style: style,
      onSaved: (valor) => _senha = valor,
      validator: (valor) {
        return valor.length < 6
            ? "Senha deve haver pelo menos 6 caracteres"
            : null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Senha',
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white10,
            child: Form(
              key: frmLoginKey,
              child: Padding(
                padding: const EdgeInsets.all(36),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RotationTransition(
                      child: Image.asset(
                        'assets/images/splash.png',
                        height: 150,
                      ),
                      turns: turnsTween.animate(_controller),
                    ),
                    SizedBox(height: 35),
                    usuarioField,
                    SizedBox(height: 35),
                    senhaField,
                    SizedBox(height: 35),
                    Container(
                      width: double.infinity,
                      height: 50.0,
                      child: RaisedButton(
                        elevation: 5.0,
                        color: Colors.blue,
                        child: Text('Login'),
                        onPressed: _validarLogin,
                      ),
                    ),
                    SizedBox(height: 35),
                    FlatButton(
                      child: Text('Registre-se'),
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => RegisterForm(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

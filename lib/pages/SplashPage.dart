import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  final Tween<double> turnsTween = Tween<double>(begin: 1, end: 5);
  AnimationController _controller;

  void navegarTelaLogin() {
    Navigator.of(context).pushReplacementNamed('/LoginPage');
  }

  iniciarSplash() async {
    var _duracao = new Duration(seconds: 3);
    _controller.forward();
    return new Timer(_duracao, navegarTelaLogin);
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 6),
    );

    iniciarSplash();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return Container(
      color: Colors.white10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RotationTransition(
            child: Image.asset('assets/images/splash.png'),
            turns: turnsTween.animate(_controller),
          ),
        ],
      ),
    );
  }
}

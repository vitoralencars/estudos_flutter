import 'package:flutter/material.dart';

class ContadorRestaurante extends StatefulWidget {
  const ContadorRestaurante({Key? key}) : super(key: key);

  @override
  _ContadorRestauranteState createState() => _ContadorRestauranteState();
}

class _ContadorRestauranteState extends State<ContadorRestaurante> {

  int _people = 0;
  String _infoText = "Pode entrar";

  void _changePeople(int delta) {
    setState(() {
      _people += delta;

      if (_people < 0) {
        _infoText = "Mundo invertido";
      } else if (_people <= 10) {
        _infoText = "Pode entrar";
      } else if (_people > 10) {
        _infoText = "Lotado";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          Image.asset(
              "images/restaurante.jpeg",
              fit: BoxFit.cover,
              height: 1000.0
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  "Pessoas: $_people",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextButton(
                        onPressed: () {
                          _changePeople(1);
                        },
                        child: Text(
                          "+1",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.0
                          ),
                        )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextButton(
                        onPressed: () {
                          _changePeople(-1);
                        },
                        child: Text(
                          "-1",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.0
                          ),
                        )
                    ),
                  )
                ],
              ),
              Text(
                  _infoText,
                  style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      fontSize: 30.0
                  )
              )
            ],
          )
        ]
    );
  }
}
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json&key=d6a72919";

class ConversorMoeda extends StatefulWidget {
  const ConversorMoeda({Key? key}) : super(key: key);

  @override
  _ConversorMoedaState createState() => _ConversorMoedaState();

}

class _ConversorMoedaState extends State<ConversorMoeda> {

  final realController = TextEditingController();
  final dollarController = TextEditingController();
  final euroController = TextEditingController();

  late double dollar;
  late double euro;

  void _onRealChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dollarController.text = (real/dollar).toStringAsFixed(2);
    euroController.text = (real/euro).toStringAsFixed(2);
  }

  void _onDollarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double dollar = double.parse(text);
    realController.text = (dollar * this.dollar).toStringAsFixed(2);
    euroController.text = (dollar * this.dollar/euro).toStringAsFixed(2);
  }

  void _onEuroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dollarController.text = (euro * this.euro/dollar).toStringAsFixed(2);
  }

  void _clearAll() {
    realController.text = "";
    dollarController.text = "";
    euroController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor \$"),
        backgroundColor: Colors.amber,
        centerTitle: true
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando dados...",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 25.0
                  ),
                  textAlign: TextAlign.center,
                )
              );
              default:
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                        "Erro ao carregar dados =(",
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 25.0
                        ),
                        textAlign: TextAlign.center,
                      )
                  );
                } else {
                  dollar = snapshot.data?["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data?["results"]["currencies"]["EUR"]["buy"];

                  return SingleChildScrollView(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(
                          Icons.attach_money_outlined,
                          size: 150.0,
                          color: Colors.amber
                        ),
                        buildTextField("Reais", "R\$ ", realController, _onRealChanged),
                        Divider(),
                        buildTextField("Dolares", "US\$ ", dollarController, _onDollarChanged),
                        Divider(),
                        buildTextField("Euros", "€ ", euroController, _onEuroChanged),
                      ],
                    )
                  );
                }
          }
        },
      ),
    );
  }
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

Widget buildTextField(
    String label,
    String preffix,
    TextEditingController controller,
    final Function(String)? onCurrencyChanged)
{
  return TextField(
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
          color: Colors.amber
      ),
      prefixText: preffix,
    ),
    style: TextStyle(
        color: Colors.amber,
        fontSize: 25.0
    ),
    keyboardType: TextInputType.numberWithOptions(decimal: true),
    controller: controller,
    onChanged: onCurrencyChanged
  );
}
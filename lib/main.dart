import 'package:flutter/material.dart';
import 'package:projeto_estudo/contador_restaurante.dart';
import 'package:projeto_estudo/conversor_moeda.dart';
import 'package:projeto_estudo/imc.dart';
import 'package:projeto_estudo/lista_tarefas.dart';

void main() {
  runApp(MaterialApp(
    title: "Contador",
    home: ListaTarefas(),
    /*theme: ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.white,
      textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.white),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
        hintStyle: TextStyle(color: Colors.amber)
      )
    ),*/
  ));
}

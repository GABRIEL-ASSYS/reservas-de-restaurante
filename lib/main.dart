import 'package:flutter/material.dart';
import 'package:reservas_restaurante/screens/cadastro.dart';
import 'package:reservas_restaurante/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reservas de Restaurante',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CadastroScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'LoginPage.dart'; // Importe a página de login
import 'MenuPage.dart'; // Importe a página de menu que queremos navegar após o login

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Semana da Liberdade e Alteridade',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Tela inicial após o login
      home: const LoginPage(),
      routes: {
        '/menu': (context) => const MenuPage(), // Definindo a rota para o menu
        // Você pode adicionar outras rotas conforme necessário
      },
    );
  }
}

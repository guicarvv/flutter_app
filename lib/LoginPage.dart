import 'package:flutter/material.dart';
import 'MenuPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _userType = 'Admin'; // padrão

  // Função para fazer login
  void _login() {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    String timestamp = DateTime.now().toString(); // Captura o horário atual

    if (_userType == 'Admin') {
      if (username == "admin" && password == "123456") {
        // Registra o login no terminal
        print('[LOGIN SUCESSO] Tipo: Admin | Usuário: $username | Data: $timestamp');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MenuPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário ou senha do Admin incorretos!')),
        );
      }
    } else if (_userType == 'Aluno') {
      // Verificação de "RM" seguido de 5 dígitos
      final rmRegex = RegExp(r'^RM\d{5}$');
      if (!rmRegex.hasMatch(username)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('O usuário do Aluno deve ser "RM" seguido de 5 números.')),
        );
        return;
      }

      if (username == "RM12345" && password == "12345") {
        // Registra o login no terminal
        print('[LOGIN SUCESSO] Tipo: Aluno | Usuário: $username | Data: $timestamp');

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MenuPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário ou senha do Aluno incorretos!')),
        );
      }
    }
  }

  // Função para entrar sem login
  void _enterWithoutLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MenuPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    IconData userIcon =
        _userType == 'Admin' ? Icons.admin_panel_settings : Icons.school;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🧩 Ícone dinâmico baseado no tipo de usuário
            Icon(
              userIcon,
              size: 100,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: _userType,
              decoration: const InputDecoration(
                labelText: 'Tipo de Usuário',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Admin', child: Text('Administrador')),
                DropdownMenuItem(value: 'Aluno', child: Text('Aluno')),
              ],
              onChanged: (value) {
                setState(() {
                  _userType = value!;
                });
              },
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Usuário',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: _login,
              child: const Text('Entrar'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 20),

            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Recuperação de senha não implementada!')),
                );
              },
              child: const Text('Esqueceu a senha?'),
            ),
            const SizedBox(height: 20),

            // Botão para entrar sem login
            TextButton(
              onPressed: _enterWithoutLogin,
              child: const Text(
                'Entrar sem login',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

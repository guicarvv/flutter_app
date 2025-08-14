import 'package:flutter/material.dart';
import 'menu_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _userType = 'Admin'; // padrão

  final Color rosaPrincipal = const Color(0xFFFB0268);

  // Função para fazer login
  void _login() {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (_userType == 'Admin') {
      if (username == "admin" && password == "123456") {
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
      final rmRegex = RegExp(r'^rm\d{5}$');
      if (!rmRegex.hasMatch(username)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('O usuário do Aluno deve ser "rm" seguido de 5 números.')),
        );
        return;
      }

      if (username == "rm90577" && password == "12345") {
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

  void _enterWithoutLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MenuPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    IconData userIcon = _userType == 'Admin' ? Icons.admin_panel_settings : Icons.school;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ícone do usuário
              CircleAvatar(
                radius: 60,
                backgroundColor: rosaPrincipal.withOpacity(0.1),
                child: Icon(
                  userIcon,
                  size: 60,
                  color: rosaPrincipal,
                ),
              ),
              const SizedBox(height: 30),

              // Dropdown tipo de usuário
              DropdownButtonFormField<String>(
                value: _userType,
                decoration: InputDecoration(
                  labelText: 'Tipo de Usuário',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: rosaPrincipal),
                    borderRadius: BorderRadius.circular(12),
                  ),
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

              // Campo usuário
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Usuário',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: rosaPrincipal),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Campo senha
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: rosaPrincipal),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Botão Entrar
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: rosaPrincipal,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Entrar',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),

              // Esqueceu senha
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Recuperação de senha não implementada!')),
                  );
                },
                child: Text(
                  'Esqueceu a senha?',
                  style: TextStyle(color: rosaPrincipal),
                ),
              ),
              const SizedBox(height: 20),

              // Entrar sem login
              TextButton(
                onPressed: _enterWithoutLogin,
                child: Text(
                  'Entrar sem login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: rosaPrincipal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

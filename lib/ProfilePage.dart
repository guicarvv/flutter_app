import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Foto do perfil (inicialmente será uma imagem padrão)
  String _profileImage = 'https://www.example.com/default-profile.png';

  // Dados do usuário editáveis
  String _userName = "João Silva";
  String _userEmail = "joao.silva@email.com";

  // Controladores para os TextFields de edição
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  // Controle de modo edição
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: _userName);
    _emailController = TextEditingController(text: _userEmail);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // Função para alternar modo edição
  void _toggleEdit() {
    if (_isEditing) {
      // Salvar alterações
      setState(() {
        _userName = _nameController.text.trim();
        _userEmail = _emailController.text.trim();
      });
    }
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  // Função para alterar a foto de perfil (simulada)
  void _changeProfilePicture() {
    if (!_isEditing) return; // Só permite trocar foto no modo edição
    setState(() {
      // Aqui você pode abrir galeria, câmera etc. 
      // Por simplicidade, só alterna entre duas imagens fixas:
      _profileImage = _profileImage == 'https://www.example.com/default-profile.png'
          ? 'https://www.example.com/new-profile.png'
          : 'https://www.example.com/default-profile.png';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit),
            tooltip: _isEditing ? 'Salvar' : 'Editar Perfil',
            onPressed: _toggleEdit,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _changeProfilePicture,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(_profileImage),
              ),
            ),
            const SizedBox(height: 20),

            _isEditing
                ? TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nome',
                      border: OutlineInputBorder(),
                    ),
                  )
                : ListTile(
                    title: const Text('Nome'),
                    subtitle: Text(_userName),
                  ),

            const SizedBox(height: 10),

            _isEditing
                ? TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  )
                : ListTile(
                    title: const Text('Email'),
                    subtitle: Text(_userEmail),
                  ),
          ],
        ),
      ),
    );
  }
}

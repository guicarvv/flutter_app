import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'reserva_evento.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> reservas = [];
  String nomeUsuario = "";
  String rmUsuario = "";
  String emailUsuario = "";
  String cursoUsuario = "";
  String turmaUsuario = "";
  String fotoPerfil = ""; // Caminho ou URL da foto

  @override
  void initState() {
    super.initState();
    _carregarDadosUsuario();
    _carregarReservas();
  }

  Future<void> _carregarDadosUsuario() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nomeUsuario = prefs.getString('nomeUsuario') ?? "Laura Fernandes";
      rmUsuario = prefs.getString('rmUsuario') ?? "rm90123";
      emailUsuario =
          prefs.getString('emailUsuario') ?? "rm90123@estudante.fieb.edu.br";
      cursoUsuario = prefs.getString('cursoUsuario') ?? "Informática";
      turmaUsuario = prefs.getString('turmaUsuario') ?? "INF2EM";
      fotoPerfil = prefs.getString('fotoPerfil') ?? ""; 
    });
  }

  Future<void> _carregarReservas() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      reservas = prefs.getStringList('palestrasReservadas') ?? [];
    });
  }

  void _abrirReserva() async {
    final mudou = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ReservaEventoPage()),
    );

    if (mudou == true) {
      _carregarReservas();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text("Perfil"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Foto do perfil
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: fotoPerfil.isNotEmpty
                    ? NetworkImage(fotoPerfil)
                    : const AssetImage('assets/user.png')
                        as ImageProvider,
              ),
            ),
            const SizedBox(height: 16),

            // Nome
            Text(
              nomeUsuario,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 20),

            // Campos de informações
            _buildInfoField("Username", rmUsuario),
            const SizedBox(height: 10),
            _buildInfoField("Email", emailUsuario),
            const SizedBox(height: 10),
            _buildInfoField("Curso", cursoUsuario),
            const SizedBox(height: 10),
            _buildInfoField("Turma", turmaUsuario),
            const SizedBox(height: 30),

            // Reservas
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Minhas Reservas:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: reservas.isEmpty
                  ? const Center(child: Text("Nenhuma reserva feita ainda."))
                  : ListView.builder(
                      itemCount: reservas.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.event),
                          title: Text(reservas[index]),
                        );
                      },
                    ),
            ),

            // Botão para nova reserva
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _abrirReserva,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Reservar Novo Evento",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoField(String label, String value) {
    return TextField(
      enabled: false,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.grey[200],
        hintText: value,
      ),
    );
  }
}

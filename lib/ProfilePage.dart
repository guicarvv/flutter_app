import 'package:flutter/material.dart';
import 'package:flutter_application_2/ReservaEvento.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ReservaEvento.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> reservas = [];

  @override
  void initState() {
    super.initState();
    _carregarReservas();
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
      _carregarReservas(); // Atualiza quando volta
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meu Perfil")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Minhas Reservas:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            reservas.isEmpty
                ? Text("Nenhuma reserva feita ainda.")
                : Column(
                    children: reservas
                        .map((reserva) => ListTile(
                              title: Text(reserva),
                              leading: Icon(Icons.event),
                            ))
                        .toList(),
                  ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: _abrirReserva,
                child: Text("Reservar Novo Evento"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

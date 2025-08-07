import 'package:flutter/material.dart';
import 'ProfilePage.dart';
import 'ReservaEvento.dart';
import 'LoginPage.dart';
import 'PalestrasPage.dart';
import 'SalasPage.dart';
import 'MapaPage.dart'; // ✅ Importando a nova página

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void _openProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Principal - S.L.A'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: 'Perfil',
            onPressed: () => _openProfile(context),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.event_seat),
              label: const Text('Reservar Evento'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReservarEventoPage()),
                );
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.mic),
              label: const Text('Palestras (Auditório)'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PalestrasPage()),
                );
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.meeting_room),
              label: const Text('Salas'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SalasPage()),
                );
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.map),
              label: const Text('Mapa Interativo'), // ✅ Novo botão
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapaPage()),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Pesquisar Evento',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: 'Digite o nome do evento...',
                border: const OutlineInputBorder(),
                suffixIcon: const Icon(Icons.search),
              ),
              onSubmitted: (value) {
                // TODO: Implementar busca de eventos
              },
            ),
          ],
        ),
      ),
    );
  }
}

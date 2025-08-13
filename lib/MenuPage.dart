import 'package:flutter/material.dart';
import 'package:flutter_application_2/ReservaEvento.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ProfilePage.dart';
import 'ReservaEvento.dart';
import 'PalestrasPage.dart';
import 'SalasPage.dart';
import 'MapaPage.dart';
import 'LoginPage.dart';
import 'dart:async';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _selectedIndex = 0;
  List<Map<String, String>> palestrasReservadas = [];

  @override
  void initState() {
    super.initState();
    _carregarReservas();
    _verificarPalestrasProximas();
  }

  Future<void> _carregarReservas() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> reservasJson = prefs.getStringList('palestrasReservadas') ?? [];
    setState(() {
      palestrasReservadas = reservasJson.map((e) => {"nome": e}).toList();
    });
  }

  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void _openProfile(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfilePage()),
    );
    _carregarReservas();
  }

  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        break;
      case 1:
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PalestrasPage()),
        );
        break;
      case 2:
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ReservaEventoPage()),
        );
        _carregarReservas();
        break;
      case 3:
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MapaPage()),
        );
        break;
    }
  }

  void _verificarPalestrasProximas() {
    // Simulação: a cada 10s verifica se alguma palestra começa
    Timer.periodic(const Duration(seconds: 10), (timer) async {
      if (palestrasReservadas.isEmpty) return;

      // Aqui você pode implementar a verificação real com hora atual
      // Exemplo fixo:
      final nome = palestrasReservadas.first['nome']!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Atenção! Faltam 5 minutos para '$nome'")),
      );
    });
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
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReservaEventoPage()),
                );
                _carregarReservas();
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.mic),
              label: const Text('Palestras (Auditório)'),
              onPressed: () async {
                await Navigator.push(
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
              label: const Text('Mapa Interativo'),
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
                // TODO: implementar busca de eventos
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.pink[100],
        selectedItemColor: Colors.pink[700],
        unselectedItemColor: Colors.pink[400],
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mic),
            label: 'Palestras',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_seat),
            label: 'Assento',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa',
          ),
        ],
      ),
    );
  }
}

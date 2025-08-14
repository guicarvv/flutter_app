import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile_page.dart';
import 'reserva_evento.dart';
import 'palestras_page.dart';
import 'mapa_page.dart';
import 'login_page.dart';
import 'dart:async';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _selectedIndex = 0;
  List<Map<String, String>> palestrasReservadas = [];
  final Color rosaPrincipal = const Color(0xFFFB0268);

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
    Timer.periodic(const Duration(seconds: 10), (timer) async {
      if (palestrasReservadas.isEmpty) return;

      final nome = palestrasReservadas.first['nome']!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Atenção! Faltam 5 minutos para '$nome'")),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: _buildDrawer(), // <-- Drawer adicionada
      appBar: AppBar(
        backgroundColor: rosaPrincipal,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // abre o menu lateral
            },
          ),
        ),
        title: Center(
          child: CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/imagens/logo.png'),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () => _openProfile(context),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              'Inicial',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),
            _menuButton('Cronograma', Icons.schedule, () {}),
            const SizedBox(height: 15),
            _menuButton('Mapa', Icons.map, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MapaPage()),
              );
            }),
            const SizedBox(height: 15),
            _menuButton('Reservar lugar', Icons.event_seat, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReservaEventoPage()),
              );
            }),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.pink[100],
        selectedItemColor: rosaPrincipal,
        unselectedItemColor: Colors.pink[400],
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.help), label: ''),
        ],
      ),
    );
  }

  // Drawer lateral
  Drawer _buildDrawer() {
    return Drawer(
      child: Container(
        color: Colors.grey[200],
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: rosaPrincipal),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/imagens/logo.png'),
                ),
              ),
            ),
            _drawerItem(Icons.home, 'Inicio', () {}),
            _drawerItem(Icons.search, 'Pesquisa de temas', () {}),
            _drawerItem(Icons.schedule, 'Cronograma', () {}),
            const Divider(),
            _drawerItem(Icons.event_seat, 'Reservar assentos', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReservaEventoPage()),
              );
            }),
            _drawerItem(Icons.person, 'Seu Perfil', () => _openProfile(context)),
            _drawerItem(Icons.info, 'Sobre-Nós', () {}),
            const Divider(),
            _drawerItem(Icons.exit_to_app, 'Sair', () => _logout(context)),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(IconData icon, String text, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: rosaPrincipal),
      title: Text(text, style: const TextStyle(fontSize: 16)),
      onTap: onTap,
    );
  }

  Widget _menuButton(String text, IconData icon, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: rosaPrincipal),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: Colors.white,
        ),
        onPressed: onPressed,
        icon: Icon(icon, color: rosaPrincipal),
        label: Text(
          text,
          style: const TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
    );
  }
}

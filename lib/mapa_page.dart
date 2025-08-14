import 'package:flutter/material.dart';
import 'menu_page.dart';
import 'reserva_evento.dart';
import 'palestras_page.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({super.key});

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  String? temaSelecionado;
  int _selectedIndex = 3; // Mapa é o 4º item (índice 3)

  final Map<String, Map<String, dynamic>> temas = {
    'Tecnologia': {
      'cor': Colors.red,
      'salas': ['01', '02', '03', '04', '05', '06']
    },
    'Educação': {
      'cor': Colors.orange,
      'salas': ['07', '08', '09', '10', '11', '12']
    },
    'Saúde': {
      'cor': Colors.pink,
      'salas': ['13', '14', '15', '16', '17', '18', '19']
    },
    'Meio Ambiente': {
      'cor': Colors.yellow,
      'salas': ['20', '21', '22', '23', '24']
    },
    'Engenharia': {
      'cor': Colors.blue,
      'salas': ['25', '26', '27', '28', '29']
    },
    'Inovação': {
      'cor': Colors.green,
      'salas': ['30', '31', '32', '33', '35']
    },
  };

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MenuPage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PalestrasPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ReservaEventoPage()),
        );
        break;
      case 3:
        // Já está na MapaPage
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa do Evento - S.L.A'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: SizedBox(
                height: 350,
                child: Image.asset(
                  'assets/mapa.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Temas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 3.5,
              children: temas.entries.map((entry) {
                final nome = entry.key;
                final cor = entry.value['cor'] as Color;

                return SizedBox(
                  height: 35,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cor,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                    onPressed: () {
                      setState(() {
                        temaSelecionado = nome;
                      });
                    },
                    child: Text(nome, textAlign: TextAlign.center),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            if (temaSelecionado != null)
              Text(
                'Salas para "$temaSelecionado": ${temas[temaSelecionado]!['salas'].join(', ')}',
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
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

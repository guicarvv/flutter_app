import 'package:flutter/material.dart';
import 'MenuPage.dart';
import 'PalestrasPage.dart';
import 'MapaPage.dart';
import 'ReservaEvento.dart'; // Opcional, pois já estamos nela

class ReservarEventoPage extends StatefulWidget {
  const ReservarEventoPage({super.key});

  @override
  State<ReservarEventoPage> createState() => _ReservarEventoPageState();
}

class _ReservarEventoPageState extends State<ReservarEventoPage> {
  final List<Map<String, dynamic>> eventos = [
    {'nome': 'Show de Rock', 'cadeirasDisponiveis': 20, 'reservadas': 0},
    {'nome': 'Palestra de Tecnologia', 'cadeirasDisponiveis': 15, 'reservadas': 0},
    {'nome': 'Peça de Teatro', 'cadeirasDisponiveis': 10, 'reservadas': 0},
  ];

  int _selectedIndex = 2; // Assento é o 3º item

  void reservarCadeira(int index) {
    setState(() {
      if (eventos[index]['reservadas'] < 2 && eventos[index]['cadeirasDisponiveis'] > 0) {
        eventos[index]['reservadas']++;
        eventos[index]['cadeirasDisponiveis']--;
      } else if (eventos[index]['reservadas'] >= 2) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Você pode reservar até 2 lugares por evento.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Não há mais cadeiras disponíveis nesse evento.')),
        );
      }
    });
  }

  void removerReserva(int index) {
    setState(() {
      if (eventos[index]['reservadas'] > 0) {
        eventos[index]['reservadas']--;
        eventos[index]['cadeirasDisponiveis']++;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Você não tem reservas para remover neste evento.')),
        );
      }
    });
  }

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
        // Já está na tela
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MapaPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservar Evento'),
      ),
      body: ListView.builder(
        itemCount: eventos.length,
        itemBuilder: (context, index) {
          final evento = eventos[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(evento['nome']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Cadeiras disponíveis: ${evento['cadeirasDisponiveis']}'),
                  Text('Reservadas por você: ${evento['reservadas']}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: evento['reservadas'] > 0 ? () => removerReserva(index) : null,
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: (evento['reservadas'] < 2 && evento['cadeirasDisponiveis'] > 0)
                        ? () => reservarCadeira(index)
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
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

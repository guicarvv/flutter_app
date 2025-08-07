import 'package:flutter/material.dart';

class ReservarEventoPage extends StatefulWidget {
  const ReservarEventoPage({super.key});

  @override
  State<ReservarEventoPage> createState() => _ReservarEventoPageState();
}

class _ReservarEventoPageState extends State<ReservarEventoPage> {
  // Lista de evnentos com cadeiras disponíveis e reservadas
  final List<Map<String, dynamic>> eventos = [
    {'nome': 'Show de Rock', 'cadeirasDisponiveis': 20, 'reservadas': 0},
    {'nome': 'Palestra de Tecnologia', 'cadeirasDisponiveis': 15, 'reservadas': 0},
    {'nome': 'Peça de Teatro', 'cadeirasDisponiveis': 10, 'reservadas': 0},
  ];

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
    );
  }
}

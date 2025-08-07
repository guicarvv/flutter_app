import 'package:flutter/material.dart';

class SalasPage extends StatefulWidget {
  const SalasPage({super.key});

  @override
  State<SalasPage> createState() => _SalasPageState();
}

class _SalasPageState extends State<SalasPage> {
  final List<Map<String, dynamic>> salas = [
    {'nome': 'Sala 101 - Reunião Geral', 'cadeirasDisponiveis': 12, 'reservadas': 0},
    {'nome': 'Sala 202 - Brainstorm Criativo', 'cadeirasDisponiveis': 8, 'reservadas': 0},
    {'nome': 'Sala 303 - Workshop de Projetos', 'cadeirasDisponiveis': 10, 'reservadas': 0},
  ];

  void reservarCadeira(int index) {
    setState(() {
      if (salas[index]['reservadas'] < 2 && salas[index]['cadeirasDisponiveis'] > 0) {
        salas[index]['reservadas']++;
        salas[index]['cadeirasDisponiveis']--;
      } else if (salas[index]['reservadas'] >= 2) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Você pode reservar até 2 lugares por sala.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Não há mais cadeiras disponíveis nesta sala.')),
        );
      }
    });
  }

  void removerReserva(int index) {
    setState(() {
      if (salas[index]['reservadas'] > 0) {
        salas[index]['reservadas']--;
        salas[index]['cadeirasDisponiveis']++;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Você não tem reservas para remover nesta sala.')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Salas')),
      body: ListView.builder(
        itemCount: salas.length,
        itemBuilder: (context, index) {
          final sala = salas[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(sala['nome']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Cadeiras disponíveis: ${sala['cadeirasDisponiveis']}'),
                  Text('Reservadas por você: ${sala['reservadas']}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: sala['reservadas'] > 0 ? () => removerReserva(index) : null,
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: (sala['reservadas'] < 2 && sala['cadeirasDisponiveis'] > 0)
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

import 'package:flutter/material.dart';

class DetalhesPalestraPage extends StatelessWidget {
  final Map<String, String> palestra;

  const DetalhesPalestraPage({super.key, required this.palestra});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(palestra['nome']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              palestra['nome']!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Data: ${palestra['data']}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Horário: ${palestra['horaInicio']} - ${palestra['horaFim']}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Apresentador: ${palestra['apresentador']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'Descrição:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              palestra['descricao']!,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aqui você pode implementar lógica real de reserva
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Reserva Confirmada'),
                    content: const Text('Sua reserva foi realizada com sucesso!'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Reservar Palestra'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

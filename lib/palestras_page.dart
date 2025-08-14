import 'package:flutter/material.dart';
import 'detalhes_palestra_page.dart';

class PalestrasPage extends StatelessWidget {
  const PalestrasPage({super.key});

  final List<Map<String, String>> palestras = const [
    {
      'nome': 'Palestra sobre Inteligência Artificial',
      'descricao': 'Uma análise detalhada das tendências em IA e suas aplicações.',
      'apresentador': 'Dr. João Silva',
      'horaInicio': '09:00',
      'horaFim': '10:30',
      'data': '15/08/2025',
    },
    {
      'nome': 'Educação Financeira para Jovens',
      'descricao': 'Dicas práticas para organizar suas finanças desde cedo.',
      'apresentador': 'Maria Oliveira',
      'horaInicio': '11:00',
      'horaFim': '12:00',
      'data': '15/08/2025',
    },
    {
      'nome': 'Desenvolvimento Pessoal',
      'descricao': 'Como melhorar suas habilidades pessoais e profissionais.',
      'apresentador': 'Carlos Pereira',
      'horaInicio': '14:00',
      'horaFim': '15:30',
      'data': '15/08/2025',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Palestras (Auditório)')),
      body: ListView.builder(
        itemCount: palestras.length,
        itemBuilder: (context, index) {
          final palestra = palestras[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(palestra['nome']!),
              subtitle: Text('Apresentador: ${palestra['apresentador']}'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetalhesPalestraPage(palestra: palestra),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Índice da aba atual (Palestras)
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/menu');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/mapa');
          } else if (index == 2) {
            // já está na página atual
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Menu'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
          BottomNavigationBarItem(icon: Icon(Icons.mic), label: 'Palestras'),
        ],
      ),
    );
  }
}

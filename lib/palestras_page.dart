import 'package:flutter/material.dart';
import 'detalhes_palestra_page.dart';

class PalestrasPage extends StatefulWidget {
  const PalestrasPage({super.key});

  @override
  State<PalestrasPage> createState() => _PalestrasPageState();
}

class _PalestrasPageState extends State<PalestrasPage> {
  final List<Map<String, String>> palestras = [
    {
      'nome': 'Inteligência Artificial no Futuro',
      'data': '15/11/2024',
      'horaInicio': '09:00',
      'horaFim': '10:30',
      'apresentador': 'Dr. João Silva',
      'descricao': 'Uma visão abrangente sobre o futuro da IA e seu impacto na sociedade.',
    },
    {
      'nome': 'Sustentabilidade e Tecnologia',
      'data': '15/11/2024',
      'horaInicio': '11:00',
      'horaFim': '12:30',
      'apresentador': 'Dra. Maria Santos',
      'descricao': 'Como a tecnologia pode contribuir para um mundo mais sustentável.',
    },
    {
      'nome': 'Inovação em Educação',
      'data': '16/11/2024',
      'horaInicio': '14:00',
      'horaFim': '15:30',
      'apresentador': 'Prof. Carlos Lima',
      'descricao': 'Novas metodologias e tecnologias aplicadas à educação.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Palestras'),
        backgroundColor: const Color(0xFFFB0268),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: palestras.length,
        itemBuilder: (context, index) {
          final palestra = palestras[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              title: Text(
                palestra['nome']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Data: ${palestra['data']}'),
                  Text('Horário: ${palestra['horaInicio']} - ${palestra['horaFim']}'),
                  Text('Apresentador: ${palestra['apresentador']}'),
                ],
              ),
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
    );
  }
}

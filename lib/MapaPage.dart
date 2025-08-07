import 'package:flutter/material.dart';

class MapaPage extends StatefulWidget {
  const MapaPage({super.key});

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  String? temaSelecionado;

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
              childAspectRatio: 3.5, // 🔧 Mais estreito e pequeno
              children: temas.entries.map((entry) {
                final nome = entry.key;
                final cor = entry.value['cor'] as Color;

                return SizedBox(
                  height: 35, // 📏 Altura pequena dos botões
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: cor,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      textStyle: const TextStyle(fontSize: 12), // 🔠 Fonte menor
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
    );
  }
}

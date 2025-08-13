import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReservaEventoPage extends StatefulWidget {
  const ReservaEventoPage({super.key});

  @override
  State<ReservaEventoPage> createState() => _ReservaEventoPageState();
}

class _ReservaEventoPageState extends State<ReservaEventoPage> {
  List<String> palestras = [
    "Palestra sobre IA",
    "Workshop de Flutter",
    "Debate sobre Sustentabilidade"
  ];

  void reservarPalestra(String nomePalestra) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> palestrasReservadas =
        prefs.getStringList('palestrasReservadas') ?? [];

    if (!palestrasReservadas.contains(nomePalestra)) {
      palestrasReservadas.add(nomePalestra);
      await prefs.setStringList('palestrasReservadas', palestrasReservadas);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reserva confirmada para $nomePalestra!')),
      );

      Navigator.pop(context, true); // Retorna para o perfil informando que mudou
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Você já reservou esta palestra!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Reservar Evento")),
      body: ListView.builder(
        itemCount: palestras.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(palestras[index]),
            trailing: ElevatedButton(
              onPressed: () => reservarPalestra(palestras[index]),
              child: Text("Reservar"),
            ),
          );
        },
      ),
    );
  }
}

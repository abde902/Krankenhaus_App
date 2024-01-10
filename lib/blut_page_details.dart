

import 'package:flutter/material.dart';
import 'patient.dart'; // Stelle sicher, dass diese Datei die korrekte Patientenklasse enthält

class BlutuntersuchungDetailPage extends StatelessWidget {
  final Patient patient;

  BlutuntersuchungDetailPage({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blutuntersuchung-Details für ${patient.name}"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Text("Details und Informationen zur Blutuntersuchung von Patient ${patient.name}"),
      ),
    );
  }
}
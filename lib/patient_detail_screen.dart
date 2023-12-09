import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'patient.dart';
import 'daten_patient.dart';

class PatientDetailScreen extends StatefulWidget {
  final Patient patient;

  PatientDetailScreen({required this.patient});

  @override
  _PatientDetailScreenState createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> {
  String diagnosis = '';

  void _speichereDiagnose(String neueDiagnose) {
    DatenVerwaltung().diagnosen[widget.patient.id] = neueDiagnose;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Diagnose wurde gespeichert.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patientenprofil'),
        backgroundColor: const Color.fromRGBO(76, 175, 80, 1),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: ListTile(
                title: Text(
                  'Name: ${widget.patient.name}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Geburtsdatum: ${DateFormat('yyyy-MM-dd').format(widget.patient.geburtsdatum)}',
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              child: ListTile(
                title: Text(
                  'Aktueller Gesundheitszustand',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(widget.patient.aktuellerGesundheitszustand),
              ),
            ),
            SizedBox(height: 10),
            Card(
              child: ListTile(
                title: Text(
                  'Diagnosen',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(DatenVerwaltung().diagnosen[widget.patient.id] ?? 'Keine Diagnose vorhanden'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: TextField(
                onChanged: (value) {
                  diagnosis = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Neue Diagnose hinzufügen',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => _speichereDiagnose(diagnosis),
              child: Text('Diagnose speichern'),
            ),
          ],
        ),
      ),
    );
  }
}

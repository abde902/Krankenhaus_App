import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'patient.dart'; // Stelle sicher, dass diese Klasse die aktualisierte Patientenklasse ist.

class PatientDetailScreen extends StatefulWidget {
  final Patient patient;

  PatientDetailScreen({required this.patient});

  @override
  _PatientDetailScreenState createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> {
  String diagnosis = '';
  Key textFieldKey = UniqueKey();

  void _speichereDiagnose(String neueDiagnose) {
    setState(() {
      widget.patient.addDiagnosis(neueDiagnose); // Füge die neue Diagnose zur Liste hinzu
      textFieldKey = UniqueKey();
    });
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
            // Name und Geburtsdatum
            Card(
              child: ListTile(
                title: Text(
                  'Name: ${widget.patient.name}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(
                  'Geburtsdatum: ${DateFormat('yyyy-MM-dd').format(widget.patient.geburtsdatum)}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 10),
            // Gesundheitszustand als Schalter
           
            // Diagnosen
            Card(
              child: ListTile(
                title: Text(
                  'Diagnosen',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: widget.patient.diagnosen.isEmpty
                    ? Text('Keine Diagnosen vorhanden')
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.patient.diagnosen
                            .map((diagnose) => Text(
                                  diagnose,
                                  style: TextStyle(color: Colors.black),
                                ))
                            .toList(),
                      ),
              ),
            ),
            SizedBox(height: 10),
            // Neue Diagnose hinzufügen
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              key: textFieldKey,
              child: TextField(
                onChanged: (value) {
                  diagnosis = value;
                  
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Neue Diagnose hinzufügen',
                ),
              ),
            ),  SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _speichereDiagnose(diagnosis),
              
              child: Text('speichern'),
            ),
             Card(
              child: ListTile(
                title: Text(
                  'Gesundheitszustand Gut',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Switch(
                  value: widget.patient.aktuellerGesundheitszustand,
                  onChanged: (value) {
                    setState(() {
                      widget.patient.aktuellerGesundheitszustand = value;
                    });
                  },
                ),
              ),
            ),
          
          ],
        ),
      ),
    );
  }
}

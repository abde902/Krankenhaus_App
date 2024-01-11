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
  String mrtTyp = '';
  Key textFieldKey = UniqueKey();
    Key mrtein = UniqueKey();

  void _speichereDiagnose(String neueDiagnose) {
    if(neueDiagnose.isNotEmpty){
    setState(() {
      widget.patient.addDiagnosis(neueDiagnose);
      diagnosis=''; // Füge die neue Diagnose zur Liste hinzu
      textFieldKey = UniqueKey();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Diagnose wurde gespeichert.')),
    );
  }
  }
  void _speichereMRTTyp() {
    if (mrtTyp.isNotEmpty) {
      setState(() {
        widget.patient.mrtBilder[mrtTyp] = []; // Erstellt einen neuen Eintrag für den MRT-Typ
        mrtTyp = ''; // Setzt den MRT-Typ zurück nach dem Speichern
         mrtein = UniqueKey();
      });
   
    }
  }
  @override
  void dispose() {
    // Überprüfen Sie, ob MRT eingeschaltet ist und ob MRT-Typen vorhanden sind
    if (widget.patient.MRT && widget.patient.mrtBilder.isEmpty) {
      // Wenn MRT eingeschaltet ist, aber keine MRT-Typen vorhanden sind, schalten Sie MRT aus
      setState(() {
        widget.patient.MRT = false;
      });
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patientenprofil'),
         backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
            ),
            ElevatedButton(
              onPressed: () => _speichereDiagnose(diagnosis),
              
              child: Text('speichern'),
            ),
            
            SizedBox(height: 10),
            // MRT-Typ hinzufügen
            Card(
              child: ListTile(
                title: Text(
                  'MRT erforderlich',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Switch(
                  value: widget.patient.MRT,
                  onChanged: (value) {
                    setState(() {
                      widget.patient.MRT = value;
                    });
                  },
                ),
              ),
            ),
            if (widget.patient.MRT) ...[
              Card(
                child: ListTile(
                  title: Text(
                    'MRT-Typen',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: widget.patient.mrtBilder.keys.isEmpty
                      ? Text('Keine MRT-Typen vorhanden')
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: widget.patient.mrtBilder.keys
                              .map((mrtTyp) => Text(
                                    mrtTyp,
                                    style: TextStyle(color: Colors.black),
                                  ))
                              .toList(),
                        ),
                ),
              ),
  Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0), 
     key: mrtein,
    child: TextField(
      onChanged: (value) {
        mrtTyp = value;
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'MRT-Typ eingeben',
      ),
    ),
  ),
  ElevatedButton(
    onPressed: _speichereMRTTyp,
    child: Text('MRT-Typ speichern'),
  ),
],

Card(
  child: ListTile(
    title: Text(
      'Blutuntersuchung erforderlich',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    trailing: Switch(
      value: widget.patient.blutuntersuchung,
      onChanged: (value) {
        setState(() {
          widget.patient.blutuntersuchung = value;
        });
      },
    ),
  ),
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
      activeTrackColor: Colors.green[200], // Farbe des Tracks, wenn der Switch aktiv ist
      activeColor: Colors.green, // Farbe des Knopfs, wenn der Switch aktiv ist
    ),
    leading: Icon(
      widget.patient.aktuellerGesundheitszustand ? Icons.check_circle : Icons.cancel,
      color: widget.patient.aktuellerGesundheitszustand ? Colors.green : const Color.fromARGB(255, 194, 25, 25),
    ),
  ),
),

          ],
        ),
      ),
    );
  }
}

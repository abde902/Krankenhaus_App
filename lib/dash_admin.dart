import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'patient.dart';
import 'daten_patient.dart'; // Stellen Sie sicher, dass diese Datei alle benötigten Informationen enthält.

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final daten = DatenVerwaltung();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verwaltungs-Dashboard'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: daten.zimmerListe.length,
        itemBuilder: (context, index) {
          final zimmer = daten.zimmerListe[index];
          // Finde den Patienten im Zimmer
          Patient? patientImZimmer = zimmer.istBelegt ? 
            daten.patientenListe.firstWhere(
              (patient) => patient.zimmerNummer == zimmer.nummer,
              
            ) : null;

          bool isPatientInGoodHealth = patientImZimmer?.aktuellerGesundheitszustand ?? false;

          return Card(
            color: isPatientInGoodHealth ? Colors.green[100] : null, // Grüner Hintergrund für gute Gesundheit
            elevation: 4.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: ListTile(
              title: Text('Zimmer ${zimmer.nummer}'),
              subtitle: Text(zimmer.istBelegt ? 'Belegt' : 'Frei'),
              leading: Icon(
                Icons.hotel, // Icon für das Zimmer
                color: zimmer.istBelegt ? (isPatientInGoodHealth ? Colors.green : const Color.fromARGB(255, 86, 54, 244)) : Colors.grey,
              ),
              trailing: zimmer.istBelegt && isPatientInGoodHealth
                ? Icon(Icons.check_circle, color: Colors.green)  // Grünes Symbol für guten Gesundheitszustand
                : null,
            onTap: () {
  if (zimmer.istBelegt) {
    Patient? patientImZimmer = daten.patientenListe.firstWhere(
      (patient) => patient.zimmerNummer == zimmer.nummer,
       // Rückgabetyp jetzt korrekt als 'Patient?' definiert
    );
    if (patientImZimmer != 0) {
      _zeigePatientenInfoUndEntlassungDialog(patientImZimmer, zimmer.nummer);
    }
  } else {
    _zeigePatientAufnahmeDialog(zimmer.nummer);
  }
},
            ),
          );
        },
      ),
    );
  }

 void _zeigePatientAufnahmeDialog(int zimmerNummer) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      TextEditingController nameController = TextEditingController();
      TextEditingController geburtsdatumController = TextEditingController();
      

      return AlertDialog(
        title: Text('Patient Aufnehmen'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: InputDecoration(hintText: "Name des Patienten"),
              ),
              TextField(
                controller: geburtsdatumController,
                decoration: InputDecoration(hintText: "Geburtsdatum (JJJJ-MM-TT)"),
              ),
              
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Aufnehmen'),
            onPressed: () {
              int neueId = daten.patientenListe.length + 1;
              Patient neuerPatient = Patient(
                id: neueId,
                name: nameController.text,
                geburtsdatum: DateTime.parse(geburtsdatumController.text),
                aktuellerGesundheitszustand: false,
                zimmerNummer: zimmerNummer,
              );
              setState(() {
                daten.patientenListe.add(neuerPatient);
                daten.zimmerListe[zimmerNummer - 1].istBelegt = true;
              });
              Navigator.of(context).pop(); // Dialog schließen
            },
          ),
        ],
      );
    },
  );
}


void _zeigePatientenInfoUndEntlassungDialog(Patient patient, int zimmerNummer) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // Formatter für das Datum ohne Zeit
      final dateFormatter = DateFormat('yyyy-MM-dd');
      final formattedBirthDate = dateFormatter.format(patient.geburtsdatum);

      return AlertDialog(
        title: Text('Patienteninformationen'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                'Name: ${patient.name}',
                style: TextStyle(color: Colors.black), // Textfarbe auf Schwarz setzen
              ),
              Text(
                'Geburtsdatum: $formattedBirthDate',
                style: TextStyle(color: Colors.black), // Textfarbe auf Schwarz setzen
              ),
              
              Text(
                'Zimmer: $zimmerNummer',
                style: TextStyle(color: Colors.black), // Textfarbe auf Schwarz setzen
              ),
              // Weitere Patienteninformationen
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Freilassen'),
            onPressed: () {
              setState(() {
                daten.patientenListe.remove(patient);
                daten.zimmerListe[zimmerNummer - 1].istBelegt = false;
              });
              Navigator.of(context).pop(); // Dialog schließen
            },
          ),

          
        ],
      );
    },
  );
}







}
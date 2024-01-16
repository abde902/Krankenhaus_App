import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'patient_detail_screen.dart';
import 'daten_patient.dart';
import 'patient.dart';

class ArztDashboard extends StatefulWidget {
  @override
  _ArztDashboardState createState() => _ArztDashboardState();
}

class _ArztDashboardState extends State<ArztDashboard> {
  final daten = DatenVerwaltung();


  @override
  Widget build(BuildContext context) {
    List<Patient> patientenListe = daten.patientenListe;



    return Scaffold(
      appBar: AppBar(
        title: const Text('Arztlabor'),
        backgroundColor: Color.fromRGBO(76, 175, 80, 1),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: patientenListe.length,
              itemBuilder: (context, index) {
                final patient = patientenListe[index];

                Color cardColor = Colors.white; // Standardfarbe
                String statusText = '';

                // Prüfen Sie den Status der Untersuchungen und passen Sie die Farbe und den Text entsprechend an
                if ((patient.MRT&& patient.mrtfertig) && (patient.blutuntersuchung  && patient.blutfertig)) {
                  cardColor =  const Color.fromARGB(255, 222, 33, 243);
                  statusText = 'Ergebnisse bereit';
                } else if ((patient.MRT&& patient.mrtfertig&&!patient.blutuntersuchung) || (patient.blutuntersuchung  && patient.blutfertig&&!patient.MRT))  {

                  cardColor = const Color.fromARGB(255, 222, 33, 243);
                  statusText = 'Ergebnisse bereit';
                }
                if(patient.aktuellerGesundheitszustand){
                    cardColor =  Color.fromRGBO(22, 148, 27, 1);
                  statusText = 'Gesundheitzustand GUT';
                }
                
                return Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  color: cardColor,
                  child: ListTile(
                    leading: Icon(Icons.person, color: Color.fromRGBO(64, 68, 193, 1)),
                    title: Text(patient.name),
                    subtitle: Text('Geburtsdatum: ${DateFormat('yyyy-MM-dd').format(patient.geburtsdatum)}\n$statusText'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PatientDetailScreen(patient: patient)),
                      ).then((result) {
                        setState(() {});
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


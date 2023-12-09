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
  String _searchTerm = '';

  @override
  Widget build(BuildContext context) {
    List<Patient> gefiltertePatientenListe = _searchTerm.isEmpty 
      ? daten.patientenListe
      : daten.patientenListe.where((patient) {
          return patient.name.toLowerCase().contains(_searchTerm.toLowerCase());
        }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Arzt-Dashboard'),
        backgroundColor: Color.fromRGBO(76, 175, 80, 1),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Patienten suchen',
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _searchTerm = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: gefiltertePatientenListe.length,
              itemBuilder: (context, index) {
                final patient = gefiltertePatientenListe[index];
                return Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  child: ListTile(
                    leading: Icon(Icons.person, color: Color.fromRGBO(64, 68, 193, 1)),
                    title: Text(patient.name),
                    subtitle: Text('Geburtsdatum: ${DateFormat('yyyy-MM-dd').format(patient.geburtsdatum)}'),
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

import 'package:flutter/material.dart';
import 'patient.dart'; // Stelle sicher, dass diese Datei die korrekte Patientenklasse enthält
import 'daten_patient.dart'; // Stelle sicher, dass diese Datei alle benötigten Informationen enthält
import 'test_detail_screen.dart';
enum LabTest { alle, MRT, blutuntersuchung }

class LabDashboard extends StatefulWidget {
  @override
  _LabDashboardState createState() => _LabDashboardState();
}

class _LabDashboardState extends State<LabDashboard> {
  final DatenVerwaltung daten = DatenVerwaltung();
  LabTest _selectedTest = LabTest.alle; // Standardmäßig alle Tests anzeigen

  @override
  Widget build(BuildContext context) {
    List<Patient> gefilterteListe = _filterPatients();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Labor Dashboard'),
         backgroundColor: Colors.green,
        actions: <Widget>[
          DropdownButton<LabTest>(
            value: _selectedTest,
            icon: Icon(Icons.filter_list, color: Colors.white),
            style: TextStyle(color: Color.fromARGB(255, 53, 21, 193), fontWeight: FontWeight.bold),
             dropdownColor: Colors.grey[200],
            onChanged: (LabTest? newValue) {
              setState(() {
                _selectedTest = newValue!;
              });
            },
            items: LabTest.values.map((LabTest test) {
              return DropdownMenuItem<LabTest>(
                value: test,
                child: Text(test.toString().split('.').last),
              );
            }).toList(),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: gefilterteListe.length,
        itemBuilder: (context, index) {
          final patient = gefilterteListe[index];

          return Card(
            child: ListTile(
              title: Text('Test ${patient.id}'),
                leading: Icon(Icons.local_hospital, color: Colors.blue),
              onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TestDetailPage(testId: patient.id)),
          );
        },
              // Weitere Informationen oder Aktionen hier hinzufügen
            ),
          ); 
        },
       

      ),
      
      
    );
    
  }

  List<Patient> _filterPatients() {
    switch (_selectedTest) {
      case LabTest.MRT:
        return daten.patientenListe.where((p) => p.MRT).toList();
      case LabTest.blutuntersuchung:
        return daten.patientenListe.where((p) => p.blutuntersuchung).toList();
      case LabTest.alle:
      default:
        return daten.patientenListe;
    }
  }
}

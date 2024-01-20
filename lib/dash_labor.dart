import 'package:flutter/material.dart';
import 'patient.dart'; // Stelle sicher, dass diese Datei die korrekte Patientenklasse enthält
import 'daten_patient.dart'; // Stelle sicher, dass diese Datei alle benötigten Informationen enthält
import 'blut_page_details.dart';
import 'mrt_page_details.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

enum LabTest { MRT, BlutBild }
class LabDashboard extends StatefulWidget {
  @override
  _LabDashboardState createState() => _LabDashboardState();
  
  
}

class _LabDashboardState extends State<LabDashboard> {
  final DatenVerwaltung daten = DatenVerwaltung();
  
  LabTest _selectedTest = LabTest.MRT; 
@override
  void dispose() {
    // Benachrichtigung anzeigen, wenn der Benutzer das Dashboard verlässt
  // Prüfen, ob ein Patient eine abgeschlossene MRT oder Blutuntersuchung hat
  bool shouldNotify = daten.patientenListe.any((patient) =>(((patient.MRT&& patient.mrtfertig) && (patient.blutuntersuchung  && patient.blutfertig))||((patient.MRT&& patient.mrtfertig&&!patient.blutuntersuchung) || (patient.blutuntersuchung  && patient.blutfertig&&!patient.MRT))));

  if (shouldNotify) {
    // Benachrichtigung anzeigen, wenn die Bedingung erfüllt ist
    showNotification();
        daten.saveData();

    super.dispose();
  }else
            super.dispose();

  }
      Future<void> showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          '1d22', 
          'adbde', 
          channelDescription: 'nnd',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
        );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, 
      'Für Arzt', 
      'Neu Ergebniss ', 
      platformChannelSpecifics,
    );
  }
  @override
  void initState() {
    super.initState();
    _selectedTest = _determineLabTest();
   
  }
  LabTest _determineLabTest() {
    // Beispiel: Wählen Sie den Test basierend auf dem ersten Patienten in der Liste
    if (daten.patientenListe.isNotEmpty) {
      Patient firstPatient = daten.patientenListe.first;
      if (firstPatient.MRT) {
        return LabTest.MRT;
      } else if (firstPatient.blutuntersuchung) {
        return LabTest.BlutBild;
      }
    }
    return LabTest.MRT; // Standardwert oder irgendeine andere Logik
  }
   void _refreshPatientList() {
    setState(() {
      // Hier könnten Sie die Liste neu laden oder nur den Zustand aktualisieren
    });
  }
  @override
  Widget build(BuildContext context) {
   
    List<Patient> gefilterteListe = _filterPatients();

    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laborportal'),
         backgroundColor: Colors.green,
        actions: <Widget>[
          DropdownButton<LabTest>(
            value: _selectedTest,
            icon: Icon(Icons.filter_list, color: Colors.white),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
            elevation: 4.0,
                  margin: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 7.0),
            child: ListTile(
              
              title:Text( 'Test ${index+1}'),
              subtitle: Text(_selectedTest == LabTest.MRT ? ' MRT ' : _selectedTest == LabTest.BlutBild ?'BLUTBILD':'n'),
              
               trailing: Text('Vorname:${patient.vorname}  Nachname:${patient.nachname}    patient ID:${patient.id}'),
               leading: Image.asset(_selectedTest == LabTest.MRT ?'assets/icons/image.png': _selectedTest == LabTest.BlutBild ?'assets/icons/blood1.png':'n'),
               onTap: ()async {
         
  if (_selectedTest == LabTest.MRT) {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MRTDetailPage(patient: patient)),
                  );
                  if (result == true) {
                    _refreshPatientList();
                  }
  } else if (_selectedTest == LabTest.BlutBild) {
    final resulte = await  Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BlutuntersuchungDetailPage(patient: patient)),
    );
   if (resulte == true) {
                    _refreshPatientList();
                  }
  }

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
      return daten.patientenListe.where((p) => p.MRT && !p.mrtfertig).toList();
    case LabTest.BlutBild:
      return daten.patientenListe.where((p) => p.blutuntersuchung && !p.blutfertig).toList();
    default:
      return daten.patientenListe.where((p) => !p.mrtfertig && !p.blutfertig).toList();
  }
}
 

}

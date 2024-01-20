import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'patient_detail_screen.dart';
import 'daten_patient.dart';
import 'patient.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class ArztDashboard extends StatefulWidget {
  @override
  _ArztDashboardState createState() => _ArztDashboardState();
}

class _ArztDashboardState extends State<ArztDashboard> {
  final daten = DatenVerwaltung();
  
@override
  void dispose() {
    // Benachrichtigung anzeigen, wenn der Benutzer das Dashboard verlässt
  // Prüfen, ob ein Patient eine abgeschlossene MRT oder Blutuntersuchung hat
  bool shouldNotify = daten.patientenListe.any((patient) =>(!((patient.MRT&& patient.mrtfertig) && (patient.blutuntersuchung  && patient.blutfertig))&&!((patient.MRT&& patient.mrtfertig&&!patient.blutuntersuchung) || (patient.blutuntersuchung  && patient.blutfertig&&!patient.MRT))&&(patient.MRT||patient.blutuntersuchung)));

  if (shouldNotify) {
    // Benachrichtigung anzeigen, wenn die Bedingung erfüllt ist
    showNotification();
    daten.saveData();
    super.dispose();
  }else { super.dispose();}

             daten.saveData();

  }
      Future<void> showNotification() async {
        if (!mounted) return;

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          '122', 
          'abde', 
          channelDescription: 'nn',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false,
        );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, 
      'Für labor', 
      'Neu TEST ', 
      platformChannelSpecifics,
    );
  }

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
                bool ergebnis_1=(patient.MRT&& patient.mrtfertig) && (patient.blutuntersuchung  && patient.blutfertig);
                bool ergebnis_2=(patient.MRT&& patient.mrtfertig&&!patient.blutuntersuchung) || (patient.blutuntersuchung  && patient.blutfertig&&!patient.MRT);
                // Prüfen Sie den Status der Untersuchungen und passen Sie die Farbe und den Text entsprechend an
                if (ergebnis_1) {
                  cardColor =  const Color.fromARGB(255, 222, 33, 243);
                  statusText = 'Ergebnisse bereit';
                } else if (ergebnis_2)  {

                  cardColor = const Color.fromARGB(255, 222, 33, 243);
                  statusText = 'Ergebnisse bereit';
                }
               else if(patient.gesundheitszustand==Gesundheitszustand.gut){
                    cardColor =  Color.fromRGBO(22, 148, 27, 1);
                  statusText = 'Gesundheitzustand GUT';
                } else if(patient.gesundheitszustand==Gesundheitszustand.schlecht){
                    cardColor =  Colors.red;
                  statusText = 'Gesundheitzustand schlecht';
                }else if(patient.gesundheitszustand==Gesundheitszustand.reduziert){
                    cardColor = Colors.deepOrange;
                  statusText = 'Gesundheitzustand reduziert';
                }else if(patient.gesundheitszustand==Gesundheitszustand.leichtReduziert){
                    cardColor = Colors.orange;
                  statusText = 'Gesundheitzustand leichtReduziert';
                }
                

                if(patient.entlassen){
                    cardColor =  Color.fromRGBO(22, 148, 27, 1);
                  statusText = 'kann entlassen ';
                }
                
                return Card(
                  elevation: 4.0,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  color: cardColor,
                  child: ListTile(leading: Icon(Icons.person, color: Color.fromRGBO(64, 68, 193, 1)),
                    title: Column( 
                   crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                        Text('Vorname: ${patient.vorname}'),
                         Text('Nachname: ${patient.nachname}'),
                          ],
                           ),
                     trailing: Text( 'patient ID:${patient.id}'),
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


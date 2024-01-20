 import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'patient.dart';
import 'daten_patient.dart'; // Stellen Sie sicher, dass diese Datei alle benötigten Informationen enthält.
import 'zimmer.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
enum ZimmerStatus { frei, belegt, entlassen }
class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final daten = DatenVerwaltung();
  ZimmerStatus? _selectedFilter;
  @override
  void dispose() {
    // Benachrichtigung anzeigen, wenn der Benutzer das Dashboard verlässt
  // Prüfen, ob ein Patient eine abgeschlossene MRT oder Blutuntersuchung hat
  bool shouldNotify = daten.patientenListe.isNotEmpty;

  if (shouldNotify) {
    // Benachrichtigung anzeigen, wenn die Bedingung erfüllt ist
   // showNotification();
    daten.saveDataToFile();
    super.dispose();
  }else
            super.dispose();

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
     List<Zimmer> gefilterteListe = _filterZimmer();

  return Scaffold(
      appBar: AppBar(
        title: const Text('Verwaltungs-Dashboard'),
        backgroundColor: Colors.green,
        actions: <Widget>[
         DropdownButton<ZimmerStatus>(
  value: _selectedFilter,
  onChanged: (ZimmerStatus? newValue) {
    setState(() {
      _selectedFilter = newValue;
    });
  },
 
  icon: Icon(Icons.filter_list, color: Colors.white),  // geändert zu einem Filter-Symbol
  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
  dropdownColor: Colors.grey[200],
   hint: Text('Filter'),
  items: ZimmerStatus.values.map((ZimmerStatus status) {
    return DropdownMenuItem<ZimmerStatus>(
      value: status,
      child: Text(
        status.toString().split('.').last,
        style: TextStyle(fontSize: 18),
      ),
    );
  }).toList(),
           
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: gefilterteListe.length,
        itemBuilder: (context, index) {
          final zimmer = gefilterteListe[index];
          Patient? patientImZimmer = zimmer.istBelegt ? 
            daten.patientenListe.firstWhere(
              (patient) => patient.zimmerNummer == zimmer.nummer,
              
            ) : null;
          bool isPatientInGoodHealth = patientImZimmer?.entlassen ?? false;

          return Card(
            color: isPatientInGoodHealth ? Colors.green[100] : null, // Grüner Hintergrund für gute Gesundheit
            elevation: 4.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: ListTile(
              title: Text('Zimmer ${zimmer.nummer}'),
              subtitle: Text( zimmer.istBelegt ?  'Belegt' : 'Frei'),
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
      // Initialisierung der Variablen und Controller
      String ausgewahltesGeschlecht =''; 
      TextEditingController vornameController = TextEditingController();
      TextEditingController nachnameController = TextEditingController();
      TextEditingController geburtsdatumController = TextEditingController();

      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Text('Patient Aufnehmen'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextField(
                    controller: vornameController,
                    decoration: InputDecoration(hintText: "Vorname des Patienten"),
                  ),
                  TextField(
                    controller: nachnameController,
                    decoration: InputDecoration(hintText: "Nachname des Patienten"),
                  ), TextField(
                    controller: geburtsdatumController,
                    decoration: InputDecoration(hintText: "Geburtsdatum (JJJJ-MM-TT)"),
                  ),
                 
                Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(
      'Geschlecht: ',
      style: TextStyle(color: Colors.black), 
    ),
    ListTile(
      title: const Text('Männlich'),
      leading: Radio<String>(
        value: 'Männlich',
        groupValue: ausgewahltesGeschlecht,
        onChanged: (String? value) {
          setState(() => ausgewahltesGeschlecht = value!);
        },
      ),
    ),
    ListTile(
      title: Text(
        'Weiblich',
        style: TextStyle(fontSize: 14), 
      ),
      leading: Radio<String>(
        value: 'Weiblich',
        groupValue: ausgewahltesGeschlecht,
        onChanged: (String? value) {
          setState(() => ausgewahltesGeschlecht = value!);
        },
      ),
    ),
  ],
)

                 
                ],
              ),
            ),
            actions: <Widget>[
             
              TextButton(
                child: Text('Aufnehmen'),
                onPressed: () {
                   if(ausgewahltesGeschlecht.isNotEmpty){
                  // Patientenerstellung und Hinzufügen zur Liste
                  int neueId = daten.patientenListe.length + 1;
                  Patient neuerPatient = Patient(
                    id: neueId,
                    vorname: vornameController.text,
                    nachname: nachnameController.text,
                    gechlecht: ausgewahltesGeschlecht,
                    geburtsdatum: DateTime.parse(geburtsdatumController.text),
                    zimmerNummer: zimmerNummer,
                  );
                  setState(() {
                    daten.patientenListe.add(neuerPatient);
                    daten.zimmerListe[zimmerNummer - 1].istBelegt = true;
                  });
                  Navigator.of(context).pop();
                }
                else{ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Zuesrt alles ausfüllen ')));
                       
                };},
              ),
            ],
          );
        },
      );
    },
  );
}



void _zeigePatientenInfoUndEntlassungDialog(Patient patient, int zimmerNummer) {
  bool freilassen=patient.entlassen;
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
                'Vorname: ${patient.vorname}',
                style: TextStyle(color: Colors.black), // Textfarbe auf Schwarz setzen
              ),
              Text(
                'Nachname: ${patient.nachname}',
                style: TextStyle(color: Colors.black), // Textfarbe auf Schwarz setzen
              ),
              Text(
                'Geschlecht: ${patient.gechlecht}',
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
          if(freilassen)
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

List<Zimmer> _filterZimmer() {
  return daten.zimmerListe.where((zimmer) {
    // Finde den Patienten, der dem Zimmer zugeordnet ist.
    Patient? patientImZimmer = zimmer.istBelegt
        ? daten.patientenListe.firstWhere(
            (patient) => patient.zimmerNummer == zimmer.nummer,
           // Wenn kein Patient gefunden wird, gibt null zurück
          )
        : null;

    switch (_selectedFilter) {
      case ZimmerStatus.frei:
        return !zimmer.istBelegt;
      case ZimmerStatus.belegt:
        return zimmer.istBelegt && patientImZimmer != null;
      case ZimmerStatus.entlassen:
        return zimmer.istBelegt &&
            patientImZimmer != null &&
            patientImZimmer.entlassen; // Überprüfe den Gesundheitszustand
      default:
        return !zimmer.istBelegt; 
    }
  }).toList();
  
}





}
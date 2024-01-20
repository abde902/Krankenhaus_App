import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'patient.dart'; // Stelle sicher, dass diese Klasse die aktualisierte Patientenklasse ist.
import 'ergebnis-page.dart';
import 'alte-ergebniss.dart';
class PatientDetailScreen extends StatefulWidget {
  final Patient patient;

  PatientDetailScreen({required this.patient});

  @override
  _PatientDetailScreenState createState() => _PatientDetailScreenState();
}

class _PatientDetailScreenState extends State<PatientDetailScreen> {
  Gesundheitszustand _zustand = Gesundheitszustand.nicht;
  String diagnosis = '';
  String mrtTyp = '';
  Key textFieldKey = UniqueKey();
    Key mrtein = UniqueKey();

  void _speichereDiagnose(String neueDiagnose) {
    if(neueDiagnose.isNotEmpty){
    setState(() {
      widget.patient.addDiagnosis(neueDiagnose);
      widget.patient.addKrankenverlaufEintrag('Diagnose: '+neueDiagnose);
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
        widget.patient.addKrankenverlaufEintrag('MRT: '+mrtTyp);
        mrtTyp = ''; // Setzt den MRT-Typ zurück nach dem Speichern
         mrtein = UniqueKey();
      });
   
    }
  }
  void _showKrankenverlaufDialog(BuildContext context, Patient patient) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Krankheitverlauf'),
        content: SingleChildScrollView(
          child: ListBody(
            children: patient.krankenverlauf.entries
              .map((eintrag) => Text(
                DateFormat('yyyy-MM-dd').format(eintrag.key) + ": " + eintrag.value,
                style: TextStyle(color: Colors.black),
              ))
              .toList(),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Schließen'),
            onPressed: () {
              Navigator.of(context).pop(); // Schließt den Dialog
            },
          ),
        ],
      );
    },
  );
}
void _oeffneErgebnissePage() async {
  await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => BlutuntersuchungErgebnissePage(patient: widget.patient)),
  );

  // Sobald der Benutzer zurückkehrt, setze MRT und Blutuntersuchung auf false
  setState(() {
    widget.patient.MRT = false;
    widget.patient.blutuntersuchung = false;
    widget.patient.archiviereKbbErgebnisse();
    widget.patient.archiviereMrtBilder();
  });
}
void _oeffneAlteErgebnissePage() {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => AlteErgebnissePage(patient: widget.patient)),
  );
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
  child: Column(
    mainAxisSize: MainAxisSize.min, // Diese Einstellung sorgt dafür, dass die Karte nicht mehr Platz als nötig einnimmt.
    children: <Widget>[
      ListTile(  leading: Icon(Icons.person, color: Color.fromRGBO(64, 68, 193, 1)), ),

      ListTile(
       
        title: Text(
          '      Vorname: ${widget.patient.vorname} ',
          style: TextStyle(fontWeight: FontWeight.bold),
          
        ),
        
      ),
      ListTile(
        
        title: Text(
          '      Nachname: ${widget.patient.nachname} ',
          style: TextStyle(fontWeight: FontWeight.bold),
          
        ),
        
      ),
        ListTile(
      
        title: Text(
          '      Zimmernummer: ${widget.patient.zimmerNummer} ',
          style: TextStyle(fontWeight: FontWeight.bold),
          
        ),
        
      ),
        ListTile(
      
        title: Text(
          '      Geschlecht: ${widget.patient.gechlecht} ',
          style: TextStyle(fontWeight: FontWeight.bold),
          
        ),
        
      ),
      ListTile(
        title: Text(
          '      Geburtsdatum: ${DateFormat('yyyy-MM-dd').format(widget.patient.geburtsdatum)}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      ElevatedButton(
            onPressed: () => _showKrankenverlaufDialog(context, widget.patient),
            child: Text('Krankheitverlauf anzeigen'),
          ),
    ],
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
              child: Text('Addieren'),
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
                    'MRT',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: widget.patient.mrtBilder.keys.isEmpty
                      ? Text('')
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
        labelText: 'Eingabe des zu scannenden Körperteils',
      ),
    ),
  ),
  ElevatedButton(
    onPressed: _speichereMRTTyp,
    child: Text(' Addieren'),
  ),
],

Card(
  child: ListTile(
    title: Text(
      'BlutBild erforderlich',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    trailing: Switch(
      value: widget.patient.blutuntersuchung,
      onChanged: (value) {
        setState(() {
          widget.patient.blutuntersuchung = value; 
          if(widget.patient.blutuntersuchung==true)
          widget.patient.addKrankenverlaufEintrag('BlutBild ');
        });
      },
    ),
  ),
),
        
          if (((widget.patient.MRT&& widget.patient.mrtfertig) && (widget.patient.blutuntersuchung  && widget.patient.blutfertig))||(( widget.patient.MRT&&  widget.patient.mrtfertig&&! widget.patient.blutuntersuchung) || ( widget.patient.blutuntersuchung  &&  widget.patient.blutfertig&&! widget.patient.MRT)))

              ElevatedButton(
                onPressed: () { 
                  setState(() {
     _oeffneErgebnissePage();
      widget.patient.mrtfertig=false;
      widget.patient.blutfertig=false;
        
    });
                 
                  
                  
                },
               
                child: Text(' NEU Ergebnisse anzeigen'),
              ),
              if(widget.patient.alteMrtBilder.isNotEmpty||widget.patient.alteKbbErgebnisse.isNotEmpty)
                ElevatedButton(
            onPressed: _oeffneAlteErgebnissePage,
            child: Text('Alte Ergebnisse anzeigen'),
          ),
     Card(
  child: Padding(
    padding: EdgeInsets.all(8.0),
    child: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Gesundheitszustand',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          
          children: <Widget>[
            _customRadioButton(Gesundheitszustand.gut, Colors.green),
            Text('Gut', style: TextStyle(color: Colors.green)),
            
          ],
        ),
        Row(
          
          children: <Widget>[
            _customRadioButton(Gesundheitszustand.leichtReduziert, Colors.orange),
            Text('Leicht reduziert', style: TextStyle(color: Colors.orange)),
            
          ],
        ),
        Row(
          
          children: <Widget>[
            _customRadioButton(Gesundheitszustand.reduziert, Colors.deepOrange),
            Text('Reduziert', style: TextStyle(color: Colors.deepOrange)),
            
          ],
        ),
        Row(
          
          children: <Widget>[
            _customRadioButton(Gesundheitszustand.schlecht, Colors.red),
            Text('Schlecht', style: TextStyle(color: Colors.red)),
          ],
        ),
      ],
    ),
  ),
),
Card(
  child: ListTile(
    title: Text(
      'kann entlassen ',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    trailing: Switch(
      value: widget.patient.entlassen,
      
      onChanged: (value) {
        setState(() {
          widget.patient.entlassen = value;
        });
      },
      activeTrackColor: Colors.green[200], // Farbe des Tracks, wenn der Switch aktiv ist
      activeColor: Colors.green, // Farbe des Knopfs, wenn der Switch aktiv ist
    ),
    leading: Icon(
      widget.patient.entlassen ? Icons.check_circle : Icons.cancel,
      color: widget.patient.entlassen ? Colors.green : const Color.fromARGB(255, 194, 25, 25),
    ),
  ),
),

          ],
        ),
      ),
    );
    
  }
 Widget _customRadioButton(Gesundheitszustand value,  Color color) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Radio<Gesundheitszustand>(
        value: value,
        groupValue: _zustand,
        onChanged: (Gesundheitszustand? newValue) {
          setState(() {
            _zustand = newValue!;
            widget.patient.setGesundheitszustand(_zustand);
            widget.patient.addKrankenverlaufEintrag(_zustand.toString());
          });
        },
        activeColor: color, // Farbe des Radio-Buttons, wenn er ausgewählt ist
      ),
      
    ],
  );
}
}

import 'package:flutter/material.dart';
import 'patient.dart'; // Ihre Patientenklasse
import 'package:intl/intl.dart';

class BlutuntersuchungDetailPage extends StatefulWidget {
  final Patient patient;

  BlutuntersuchungDetailPage({required this.patient});

  @override
  _BlutuntersuchungDetailPageState createState() => _BlutuntersuchungDetailPageState();
}

class _BlutuntersuchungDetailPageState extends State<BlutuntersuchungDetailPage> {
  TextEditingController hbController = TextEditingController();
  TextEditingController wbcController = TextEditingController();
  TextEditingController pltController = TextEditingController();
  TextEditingController hctController = TextEditingController();
  TextEditingController rbcController = TextEditingController();
   
void saveBloodTestResults() {
  // Überprüfung und Speicherung jedes Parameters, falls nicht leer
  if (hbController.text.isNotEmpty) {
    double hb = double.parse(hbController.text);
    widget.patient.addKBBErgebnis("Hb", hb);
  }

  if (wbcController.text.isNotEmpty) {
    double wbc = double.parse(wbcController.text);
    widget.patient.addKBBErgebnis("WBC", wbc);
  }

  if (pltController.text.isNotEmpty) {
    double plt = double.parse(pltController.text);
    widget.patient.addKBBErgebnis("PLT", plt);
  }

  if (hctController.text.isNotEmpty) {
    double hct = double.parse(hctController.text);
    widget.patient.addKBBErgebnis("Hct", hct);
  }

  if (rbcController.text.isNotEmpty) {
    double rbc = double.parse(rbcController.text);
    widget.patient.addKBBErgebnis("RBC", rbc);
  }

  // Zeigen Sie eine Bestätigungsnachricht an
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Blutuntersuchungsergebnisse gespeichert.')));
}
 void _blutComplete() {var kbbErgebnisse = widget.patient.getKBBErgebnisse();
 if(kbbErgebnisse.isNotEmpty){
    setState(() {
      widget.patient.blutfertig = true;
    });
   Navigator.pop(context, true);  // Kehrt zur vorherigen Seite zurück
  } else{
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Die Ergebnis ist noch nicht vollständig')));

  }
  
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("BlutBild-Details für ${widget.patient.vorname}"),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
         Card(
  child: Column(
    mainAxisSize: MainAxisSize.min, // Diese Einstellung sorgt dafür, dass die Karte nicht mehr Platz als nötig einnimmt.
    children: <Widget>[  ListTile(leading: Icon(Icons.person, color: Color.fromRGBO(64, 68, 193, 1)), ),
      ListTile(
       
        title: Text(
          '      Vorname: ${widget.patient.vorname}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      ListTile(
         
        title: Text(
          '      Nachname: ${widget.patient.nachname}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      ListTile(
        leading: Icon(Icons.cake, color: Color.fromRGBO(64, 68, 193, 1)), 
        title: Text(
          'Geburtsdatum: ${DateFormat('yyyy-MM-dd').format(widget.patient.geburtsdatum)}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    ],
  ),
),
            TextField(
              controller: hbController,
              decoration: InputDecoration(labelText: 'Hämoglobin (Hb) in g/dL'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: wbcController,
              decoration: InputDecoration(labelText: 'Leukozyten (WBC) in Tausend/µL'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: pltController,
              decoration: InputDecoration(labelText: 'Thrombozyten (PLT) in Tausend/µL'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: hctController,
              decoration: InputDecoration(labelText: 'Hämatokrit (Hct) in %'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: rbcController,
              decoration: InputDecoration(labelText: 'Erythrozyten (RBC) in Millionen/µL'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: saveBloodTestResults,
              child: Text('Ergebnisse speichern'),
            ),
              Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: ElevatedButton(
                onPressed: _blutComplete,
                child: Text('Fertig'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
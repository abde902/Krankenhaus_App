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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blutuntersuchung-Details für ${widget.patient.name}"),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
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
          ],
        ),
      ),
    );
  }
}
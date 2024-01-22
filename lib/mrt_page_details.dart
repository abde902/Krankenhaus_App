import 'package:flutter/material.dart';
import 'patient.dart'; // Ihre Patientenklasse
import 'package:intl/intl.dart';


class MRTDetailPage extends StatefulWidget {
  final Patient patient;

  MRTDetailPage({required this.patient});

  @override
  _MRTDetailPageState createState() => _MRTDetailPageState();
}

class _MRTDetailPageState extends State<MRTDetailPage> {
  String selectedMRTTyp = '';
  List<String> ausgewaehlteBilder = [];

  @override
  void initState() {
    super.initState();
    if (widget.patient.mrtBilder.isNotEmpty) {
      selectedMRTTyp = widget.patient.mrtBilder.keys.first;
    }
  }

  void addImageToListAndShow() {
    if (selectedMRTTyp.isNotEmpty) {
      setState(() {
        ausgewaehlteBilder.forEach((bild) {
          widget.patient.addMRTBild(selectedMRTTyp, bild);
              

        });
        ausgewaehlteBilder.clear();
        
      });
      if(ausgewaehlteBilder.isNotEmpty)ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(' gespeichert.')));
    }
  }

  void _markMRTAsComplete() {
    bool hatMRTBilder = widget.patient.hatMRTBilder();
    if (!hatMRTBilder) {
      setState(() {
        widget.patient.mrtfertig = true;
      });
      Navigator.of(context).pop(true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Die Ergebnis ist noch nicht vollständig')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MRT-Details für ${widget.patient.vorname}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Patienteninformationen
            Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Vorname: ${widget.patient.vorname}', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  ListTile(
                    title: Text('Nachname: ${widget.patient.nachname}', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  ListTile(
                    leading: Icon(Icons.cake),
                    title: Text('Geburtsdatum: ${DateFormat('yyyy-MM-dd').format(widget.patient.geburtsdatum)}', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
            // DropdownButton für MRT-Typen
            if (widget.patient.mrtBilder.isNotEmpty) ...[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedMRTTyp,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedMRTTyp = newValue!;
                              ausgewaehlteBilder.clear();

                      
                    });
                  },
                  items: widget.patient.mrtBilder.keys.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
            // GridView für Bildauswahl
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
              ),
              itemCount: 4, // Anzahl der Bilder
              itemBuilder: (context, index) {
                String imgName = 'pg$index.jpg';
                bool istAusgewaehlt = ausgewaehlteBilder.contains(imgName);
                return GestureDetector(
                  onTap: () {
                    
                    setState(() {
                      if (istAusgewaehlt) {
                        ausgewaehlteBilder.remove(imgName);
                      } else {
                        ausgewaehlteBilder.add(imgName);
                       istAusgewaehlt=true;
                      }
                    });
                  },
                     child: GridTile(
                    child: Stack(
                      fit: StackFit.expand,
                      
                      children: [
                        Image.asset(
                          'assets/images/$imgName',
                          fit: BoxFit.cover,
                        ),
                        if (istAusgewaehlt)
                          Align(
                            alignment: Alignment.topRight,
                            child: Icon(Icons.check_circle, color: Color.fromARGB(255, 77, 63, 177)),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
            // Button zum Speichern der Bilder
            ElevatedButton(
              onPressed: addImageToListAndShow,
              child: Text('Bilder speichern'),
            ),
            // Fertig-Button
            ElevatedButton(
              onPressed: _markMRTAsComplete,
              child: Text('Fertig'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

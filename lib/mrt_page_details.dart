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
  String imageName = '';
   
  @override
  void initState() {
    super.initState();
    if (widget.patient.mrtBilder.isNotEmpty) {
      selectedMRTTyp = widget.patient.mrtBilder.keys.first;
    }
  }

  void addImageToListAndShow() {
    if (imageName.isNotEmpty && selectedMRTTyp.isNotEmpty) {
      setState(() {
        widget.patient.addMRTBild(selectedMRTTyp, imageName);
        imageName = ''; // Bildname zurücksetzen nach dem Hinzufügen
      });
    }
  }
  void removeImageFromList(String typ,String imag,){
setState(() {
        widget.patient.removeMRTBild(typ, imag);
      });

  }
  void _markMRTAsComplete() {bool hatMRTBilder = widget.patient.hatMRTBilder();
    if (hatMRTBilder) {
    setState(() {
      widget.patient.mrtfertig = true;
    });
    Navigator.of(context).pop(true); // Rückgabewert true, wenn fertig
    }else{
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Die Ergebnis ist noch nicht vollständig')));
    }
  }

  @override
  Widget build(BuildContext context) {
     return WillPopScope(
     
    onWillPop: () async {
      // Dialog anzeigen, wenn versucht wird, zurückzugehen
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Warnung'),
          content: Text('auf fertig drücken ,wenn alles gespeichert '),
          actions: <Widget>[
            // Schließen-Button
            TextButton(
              child: Text('Schließen'),
              onPressed: () {
                Navigator.of(context).pop(false); // Dialog schließen und nicht zurückgehen
              },
            ),
          ],
        ),
      ) ?? false; // Verhindert das Zurückgehen, falls der Dialog abgebrochen wird
    },
    child: Scaffold(
      appBar: AppBar(
        title: Text("MRT-Details für ${widget.patient.vorname}"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
             Card(
  child: Column(
    mainAxisSize: MainAxisSize.min, // Diese Einstellung sorgt dafür, dass die Karte nicht mehr Platz als nötig einnimmt.
    children: <Widget>[ListTile(leading: Icon(Icons.person, color: Color.fromRGBO(64, 68, 193, 1)), ),
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



if (widget.patient.mrtBilder.isNotEmpty) ...[
  Padding(
    padding: EdgeInsets.all(16.0),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            'scannende Körperteil auswählen:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 2,
          child: DropdownButton<String>(
            isExpanded: true,
            value: selectedMRTTyp,
            onChanged: (String? newValue) {
              setState(() {
                selectedMRTTyp = newValue!;
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
    ),
  ),
],

Padding(
  padding: EdgeInsets.all(16.0),
  child: Row(
    children: [
      Text(
        'MRT-Bildname eingeben',
        style: TextStyle(
          fontSize: 16.0,
          // Ajoutez d'autres styles au besoin
        ),
      ),
      Expanded(
        child: TextField(
          onChanged: (value) {
            imageName = value;
          },
          decoration: InputDecoration(
            labelText: '  pg(mrt_nieren), pl(mrt_meniskus), pk(mrt_wirkensaeule) oder sn(mrt_wirkensäule1)',
          ),
        ),
      ),
    ],
  ),
),


            ElevatedButton(
              onPressed: addImageToListAndShow,
              child: Text('Bild  hinzufügen'),
            ),
            // Anzeige der Bilder für den ausgewählten
            if (selectedMRTTyp.isNotEmpty) ...[
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Bilder für $selectedMRTTyp:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: widget.patient.mrtBilder[selectedMRTTyp]?.length ?? 0,
                itemBuilder: (context, index) {
                  String imgName = widget.patient.mrtBilder[selectedMRTTyp]![index];
                  return GridTile(
                    child: Image.asset(
                      'assets/images/$imgName.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                         WidgetsBinding.instance.addPostFrameCallback((_) => removeImageFromList(selectedMRTTyp,imgName));
                        return Container();
                      },
                    ),
                  );
                },
              ),
            ],
              Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: ElevatedButton(
                onPressed: _markMRTAsComplete,
                child: Text('Fertig'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    ),);
  }
}

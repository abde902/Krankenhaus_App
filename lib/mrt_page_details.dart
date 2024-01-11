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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MRT-Details für ${widget.patient.name}"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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




if (widget.patient.mrtBilder.isNotEmpty) ...[
  Padding(
    padding: EdgeInsets.all(16.0),
    child: Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            'MRT-Typ auswählen:',
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
              child: TextField(
                onChanged: (value) {
                  imageName = value;
                },
                decoration: InputDecoration(
                  labelText: 'Bildname eingeben (z.B. bild.jpg)',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: addImageToListAndShow,
              child: Text('Bild zum ausgewählten MRT-Typ hinzufügen'),
            ),
            // Anzeige der Bilder für den ausgewählten MRT-Typ
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
                         WidgetsBinding.instance!.addPostFrameCallback((_) => removeImageFromList(selectedMRTTyp,imgName));
                        return Container();
                      },
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

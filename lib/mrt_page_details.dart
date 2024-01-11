import 'package:flutter/material.dart';
import 'patient.dart'; // Ihre Patientenklasse

class MRTDetailPage extends StatefulWidget {
  final Patient patient;

  MRTDetailPage({required this.patient});

  @override
  _MRTDetailPageState createState() => _MRTDetailPageState();
}

class _MRTDetailPageState extends State<MRTDetailPage> {
  String imageName = '';

  void addImageToListAndShow() {
    if (imageName.isNotEmpty) {
      setState(() {
        widget.patient.addMRTImage(imageName);
        imageName = ''; // Bildname zurücksetzen nach dem Hinzufügen
      });
    }
  }
 void removeImageFromList(String imageName) {
    setState(() {
      widget.patient.removeMRTImage(imageName);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MRT-Details für ${widget.patient.name}"),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) {
                imageName = value;
              },
              decoration: InputDecoration(
                labelText: 'Bildname eingeben (z.B. bild)',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: addImageToListAndShow,
            child: Text('Bild hinzufügen'),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Zwei Elemente pro Zeile
                crossAxisSpacing: 10, // Horizontaler Abstand zwischen den Elementen
                mainAxisSpacing: 10, // Vertikaler Abstand zwischen den Elementen
              ),
              itemCount: widget.patient.mrts.length,
              itemBuilder: (context, index) {
                String imgName = widget.patient.mrts[index];
                return GridTile(
                  child: Image.asset(
                    'assets/images/$imgName.jpg',
                    key: ValueKey(imgName),
                    fit: BoxFit.cover, // Bild an die Größe des Grid-Elements anpassen
                    errorBuilder: (context, error, stackTrace) {
  
                      // Wenn ein Fehler auftritt, entfernen Sie das Bild aus der Liste
                      WidgetsBinding.instance!.addPostFrameCallback((_) => removeImageFromList(imgName));
                      return Center(child: Text('Bild konnte nicht geladen werden.'));
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

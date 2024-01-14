import 'package:flutter/material.dart';
import 'patient.dart'; // Ihre Patientenklasse

class BlutuntersuchungErgebnissePage extends StatelessWidget {
  final Patient patient;

  BlutuntersuchungErgebnissePage({required this.patient});

  @override
  Widget build(BuildContext context) { 
    var kbbErgebnisse = patient.getKBBErgebnisse();
return Scaffold(
      appBar: AppBar(
        title: Text("Ergebnisse "),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [  
              Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Text(patient.blutuntersuchung?
          'Blutuntersuchung :':'',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
              kbbErgebnisse.isNotEmpty 
                ? ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: _buildTableRows(kbbErgebnisse),
                  )
                : Center(),
              _buildMRTBilderSection(context),
            ],
          ),
        ),
      ),
    );

  }

  List<Widget> _buildTableRows(Map<String, double> kbbErgebnisse) {
    List<Widget> rows = [
      _buildTableRow('Parameter', 'Wert', isHeader: true)
    ];

    kbbErgebnisse.forEach((key, value) {
      rows.add(_buildTableRow(_getParameterName(key), '${value.toString()} ${_getEinheit(key)}'));
    });

    return rows;
  }

   Widget _buildTableRow(String left, String right, {bool isHeader = false}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 3, 1, 1)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(left, style: TextStyle(fontWeight: isHeader ? FontWeight.bold : FontWeight.normal, color: Colors.black)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(right, style: TextStyle(fontWeight: isHeader ? FontWeight.bold : FontWeight.normal, color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }

  String _getParameterName(String abbr) {
    switch (abbr) {
      case 'Hb':
        return 'Hämoglobin';
      case 'WBC':
        return 'Leukozyten';
      case 'PLT':
        return 'Thrombozyten';
      case 'Hct':
        return 'Hämatokrit';
      case 'RBC':
        return 'Erythrozyten';
      default:
        return abbr;
    }
  }

  String _getEinheit(String parameter) {
    switch (parameter) {
      case 'Hb':
        return 'g/dL';
      case 'WBC':
        return 'Tausend/µL';
      case 'PLT':
        return 'Tausend/µL';
      case 'Hct':
        return '%';
      case 'RBC':
        return 'Millionen/µL';
      default:
        return '';
    }
  }
   Widget _buildMRTBilderSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [ 
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Text(patient.MRT ? 'MRT-Bilder:' : '', 
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), 
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: patient.mrtBilder.values.expand((x) => x).length,
          itemBuilder: (context, index) {
            String imgName = patient.mrtBilder.values.expand((x) => x).elementAt(index);
            return GestureDetector(
              onTap: () => _showFullImage(context, imgName),
              child: GridTile(
                child: Image.asset(
                  'assets/images/$imgName.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(child: Text('Bild konnte nicht geladen werden.'));
                  },
                ),
                footer: GridTileBar(
                  backgroundColor: Colors.black45,
                  title: Text(
                    imgName,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  void _showFullImage(BuildContext context, String imgName) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Vollbildansicht'),
          backgroundColor: Colors.black,
        ),
        body: Center(
          child: Image.asset(
            'assets/images/$imgName.jpg',
            fit: BoxFit.contain,
          ),
        ),
      );
    }));
  }
}




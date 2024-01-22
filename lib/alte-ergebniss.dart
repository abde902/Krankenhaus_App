import 'package:flutter/material.dart';
import 'patient.dart'; // Ihre Patientenklasse
import 'package:intl/intl.dart';
class AlteErgebnissePage extends StatelessWidget {
  final Patient patient;

  AlteErgebnissePage({required this.patient});

  @override
  Widget build(BuildContext context) {
    var alteKbbErgebnisse = patient.alteKbbErgebnisse;
    var alteMrtBilder = patient.alteMrtBilder;

    return Scaffold(
      appBar: AppBar(
        title: Text("Alte Ergebnisse"),
        backgroundColor: Color.fromARGB(255, 170, 28, 156),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildKbbErgebnisseSection(alteKbbErgebnisse),
              SizedBox(height: 16.0),
              _buildMrtBilderSection(alteMrtBilder),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildKbbErgebnisseSection(Map<DateTime, Map<String, double>> ergebnisse) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ergebnisse.entries.map((entry) {
        return Card(
          child: Column(
            children: [
              ListTile(
                 title: Text("Blutbild - Datum: ${_formatDateTime(entry.key)}"),
              ),
              ...entry.value.entries.map((e) => ListTile(
                title: Text("${_getParameterName(e.key)}: ${e.value.toString()} ${_getEinheit(e.key)}"),
              )),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMrtBilderSection(Map<DateTime, Map<String, List<String>>> bilder) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: bilder.entries.map((entry) {
        return Card(
          child: Column(
            children: [
              ListTile(
                 title: Text("MRT-Bilder - Datum: ${_formatDateTime(entry.key)}"),
              ),
              ...entry.value.entries.map((mrtTypEntry) => _buildMrtBilderGrid(mrtTypEntry.key, mrtTypEntry.value)),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildMrtBilderGrid(String mrtTyp, List<String> bilder) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: bilder.length,
      itemBuilder: (context, index) {
        String imgName = bilder[index];
        return GestureDetector(
          onTap: () => _showFullImage(context, imgName),
          child: GridTile(
            child: Image.asset(
              'assets/images/$imgName',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(child: Text('Bild konnte nicht geladen werden.'));
              },
            ),
            footer: GridTileBar(
              backgroundColor: Colors.black45,
              title: Text(
                mrtTyp,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }
String _formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd  HH:mm:ss').format(dateTime);
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
            'assets/images/$imgName',
            fit: BoxFit.contain,
          ),
        ),
      );
    }));
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
}

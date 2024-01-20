
import 'zimmer.dart';
import 'patient.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
class DatenVerwaltung {
  static final DatenVerwaltung _singleton = DatenVerwaltung._internal();
  factory DatenVerwaltung() {
    return _singleton;
  }
  DatenVerwaltung._internal();

  List<Zimmer> zimmerListe = List.generate(20, (index) => Zimmer(nummer: index + 1));
  List<Patient> patientenListe = [];


   Future<File> _getLocalFile(String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$filename');
  }

  Future<void> saveDataToFile() async {
    final file = await _getLocalFile('data.json');

    Map<String, dynamic> data = {
      'zimmerListe': zimmerListe.map((z) => z.toJson()).toList(),
      'patientenListe': patientenListe.map((p) => p.toJson()).toList(),
    };

    await file.writeAsString(jsonEncode(data)); 
  }
  
  Future<void> loadDataFromFile() async {
    try {
      final file = await _getLocalFile('data.json');
      final contents = await file.readAsString();
      final data = jsonDecode(contents) as Map<String, dynamic>;

      zimmerListe = List<Zimmer>.from(data['zimmerListe'].map((z) => Zimmer.fromJson(z)));
      patientenListe = List<Patient>.from(data['patientenListe'].map((p) => Patient.fromJson(p)));
    } catch (e) {
      // Handle error, e.g., file not found
    }
  }


  
 
}

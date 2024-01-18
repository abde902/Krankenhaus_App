import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'zimmer.dart';
import 'patient.dart';

class DatenVerwaltung {
  static final DatenVerwaltung _singleton = DatenVerwaltung._internal();
  factory DatenVerwaltung() {
    return _singleton;
  }
  DatenVerwaltung._internal();

  List<Zimmer> zimmerListe = List.generate(20, (index) => Zimmer(nummer: index + 1));
  List<Patient> patientenListe = [];

  // Methode, um den Pfad zum lokalen Dokumentenverzeichnis zu erhalten
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // Methode, um den Pfad zur Daten-Datei zu erhalten
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/daten.json');
  }

  // Methode zum Schreiben der Daten in eine JSON-Datei
  Future<File> writeData() async {
    final file = await _localFile;
    
    // Konvertieren der Zimmer- und Patientenlisten in JSON-Format
    Map<String, dynamic> data = {
      'zimmer': zimmerListe.map((zimmer) => zimmer.toJson()).toList(),
      'patienten': patientenListe.map((patient) => patient.toJson()).toList(),
    };

    // Konvertieren des Maps in einen JSON-String und Schreiben in die Datei
    return file.writeAsString(jsonEncode(data));
  }

  
 
}

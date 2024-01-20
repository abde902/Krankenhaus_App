
import 'zimmer.dart';
import 'patient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DatenVerwaltung {
  static final DatenVerwaltung _singleton = DatenVerwaltung._internal();
  factory DatenVerwaltung() {
    return _singleton;
  }
  DatenVerwaltung._internal();

  List<Zimmer> zimmerListe = List.generate(20, (index) => Zimmer(nummer: index + 1));
  List<Patient> patientenListe = [];

 Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();

    String zimmerListeJson = jsonEncode(zimmerListe.map((z) => z.toJson()).toList());
    await prefs.setString('zimmerListe', zimmerListeJson);
    print('Saved ZimmerListe: $zimmerListeJson'); // Print the saved zimmerListe

    String patientenListeJson = jsonEncode(patientenListe.map((p) => p.toJson()).toList());
    await prefs.setString('patientenListe', patientenListeJson);
      print('Saved PatientenListe: $patientenListeJson'); // Print the saved patientenListe
 }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    List<dynamic> zimmerJson = jsonDecode(prefs.getString('zimmerListe') ?? '[]');
    List<dynamic> patientenJson = jsonDecode(prefs.getString('patientenListe') ?? '[]');

    zimmerListe = zimmerJson.map((z) => Zimmer.fromJson(z)).toList();
    patientenListe = patientenJson.map((p) => Patient.fromJson(p)).toList();
  }
  

  
 
}

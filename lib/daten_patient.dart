
import 'zimmer.dart';
import 'patient.dart';
class DatenVerwaltung {
  static final DatenVerwaltung _singleton = DatenVerwaltung._internal();

  factory DatenVerwaltung() {
    return _singleton;
  }

  DatenVerwaltung._internal();
   Map<int, String> diagnosen = {}; // Globale Variable für Diagnosen
  List<Zimmer> zimmerListe = List.generate(20, (index) => Zimmer(nummer: index + 1));
  List<Patient> patientenListe = [];
}

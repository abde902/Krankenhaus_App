
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


 
}

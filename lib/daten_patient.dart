
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


   void updatePatient(Patient updatedPatient) {
    // Suchen des Patienten in der Liste anhand seiner ID
    int index = patientenListe.indexWhere((patient) => patient.id == updatedPatient.id);
    if (index != -1) {
      // Aktualisieren des Patienten in der Liste
      patientenListe[index] = updatedPatient;
    }
  }
}

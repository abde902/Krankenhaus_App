

class Patient {
  final int id;
  final String name;
  final DateTime geburtsdatum;
  String aktuellerGesundheitszustand;
  int zimmerNummer;  // Hinzugefügte Variable für die Zimmernummer
  String diagnose;  // Hinzugefügte Variable für die Diagnose

  Patient({
    required this.id,
    required this.name,
    required this.geburtsdatum,
    required this.aktuellerGesundheitszustand,
    required this.zimmerNummer,  // Initialisierung der Zimmernummer im Konstruktor
    this.diagnose = '',  // Die Diagnose wird standardmäßig als leer initialisiert
  });

  // Methode zum Hinzufügen oder Aktualisieren der Diagnose
  void addDiagnosis(String newDiagnosis) {
    diagnose = newDiagnosis;
  }
  }

  // ... (Weitere Methoden und Logik der Klasse)


class Patient {
  final int id;
  final String name;
  final DateTime geburtsdatum;
  bool aktuellerGesundheitszustand;
  int zimmerNummer;  // Variable für die Zimmernummer
  List<String> diagnosen;  // Geänderte Variable für die Diagnosen als Liste
    bool MRT;
    bool blutuntersuchung;

  Patient({
    required this.id,
    required this.name,
    required this.geburtsdatum,
     this.aktuellerGesundheitszustand=false,
     this.MRT=false,
     this.blutuntersuchung=false,
    required this.zimmerNummer,
    List<String>? initialDiagnosen,  // Optionale Initialisierung der Diagnosen
  }) : diagnosen = initialDiagnosen ?? [];  // Standardmäßig eine leere Liste, wenn keine Diagnosen gegeben sind

  // Methode zum Hinzufügen einer Diagnose
  void addDiagnosis(String newDiagnosis) {
    diagnosen.add(newDiagnosis);
  }

  // Methode zum Löschen einer Diagnose
  void removeDiagnosis(String diagnosisToRemove) {
    diagnosen.remove(diagnosisToRemove);
  }

  // Methode zum Aktualisieren der Diagnosenliste
  void updateDiagnoses(List<String> newDiagnoses) {
    diagnosen = newDiagnoses;
  }


}

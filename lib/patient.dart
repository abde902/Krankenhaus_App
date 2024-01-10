class Patient {
  final int id;
  final String name;
  final DateTime geburtsdatum;
  bool aktuellerGesundheitszustand;
  int zimmerNummer;  // Variable für die Zimmernummer
  List<String> diagnosen;  // Liste für die Diagnosen
  bool MRT;
  bool blutuntersuchung;
  List<String> mrts;  // Liste für MRT-Diagnosen
  // Liste für Blutuntersuchungen

  Patient({
    required this.id,
    required this.name,
    required this.geburtsdatum,
    this.aktuellerGesundheitszustand = false,
    this.MRT = false,
    this.blutuntersuchung = false,
    required this.zimmerNummer,
    List<String>? initialDiagnosen,
    List<String>? initialMRTs,
    
  }) : diagnosen = initialDiagnosen ?? [],
       mrts = initialMRTs ?? [];

  // Methode zum Hinzufügen einer Diagnose
  void addDiagnosis(String newDiagnosis) {
    diagnosen.add(newDiagnosis);
  }

 void addMRTImage(String imageName) {
    mrts.add(imageName);
  }

}

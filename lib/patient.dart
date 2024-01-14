class Patient {
  final int id;
  final String name;
  final DateTime geburtsdatum;
  bool aktuellerGesundheitszustand;
  int zimmerNummer;
  List<String> diagnosen;
  bool MRT;
  bool blutuntersuchung;
  bool mrtfertig;
  bool blutfertig;
  List<String> mrts;
  Map<String, List<String>> mrtBilder = {};
  Map<String, double> kbbErgebnisse = {}; // Map für KBB-Ergebnisse

  Patient({
    required this.id,
    required this.name,
    required this.geburtsdatum,
    this.aktuellerGesundheitszustand = false,
    this.MRT = false,
    this.blutuntersuchung = false,
    this.mrtfertig=false,
    this.blutfertig=false,
    required this.zimmerNummer,
    List<String>? initialDiagnosen,
    List<String>? initialMRTs,
  }) : diagnosen = initialDiagnosen ?? [],
       mrts = initialMRTs ?? [];

  void addDiagnosis(String newDiagnosis) {
    diagnosen.add(newDiagnosis);
  }

  void addMRTBild(String mrtTyp, String bildName) {
    if (!mrtBilder.containsKey(mrtTyp)) {
      mrtBilder[mrtTyp] = [];
    }
    mrtBilder[mrtTyp]!.add(bildName);
  }

  void removeMRTBild(String mrtTyp, String bildName) {
    mrtBilder[mrtTyp]?.remove(bildName);
  }
    bool hatMRTBilder() {
    // Überprüfen, ob die Map mrtBilder irgendwelche Einträge hat
    return mrtBilder.values.any((bilderListe) => bilderListe.isNotEmpty);
  }

  // Methode zum Hinzufügen von KBB-Ergebnissen
  void addKBBErgebnis(String parameter, double wert) {
    kbbErgebnisse[parameter] = wert;
  }

  //Methode, um alle KBB-Ergebnisse zu erhalten
  Map<String, double> getKBBErgebnisse() {
    return kbbErgebnisse;
  }
}

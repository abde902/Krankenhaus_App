class Patient {
  final int id;
  final String vorname;
  final String nachname;
  final String ? gechlecht ;
  final DateTime geburtsdatum;
  bool entlassen;
  int zimmerNummer;
  List<String> diagnosen;
  bool MRT;
  bool blutuntersuchung;
  bool mrtfertig;
  bool blutfertig;
  List<String> mrts;
  Map<String, List<String>> mrtBilder = {};
  Map<String, double> kbbErgebnisse = {}; // Map für KBB-Ergebnisse
  Map<DateTime, String> krankenverlauf = {};
  Gesundheitszustand gesundheitszustand; 
  Map<DateTime, Map<String, double>> alteKbbErgebnisse = {};
  Map<DateTime, Map<String, List<String>>> alteMrtBilder = {};
  Patient({
    required this.id,
    required this.vorname,
     required this.nachname ,
    required this.geburtsdatum,
    required this.gechlecht,
    this.entlassen = false,
    this.MRT = false,
    this.blutuntersuchung = false,
    this.mrtfertig=false,
    this.blutfertig=false,
    required this.zimmerNummer,
    this.gesundheitszustand = Gesundheitszustand.nicht,
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


void addKrankenverlaufEintrag(String beschreibung) {
    krankenverlauf[DateTime.now()] = beschreibung;
  }
void setGesundheitszustand(Gesundheitszustand neuerZustand) {
  gesundheitszustand = neuerZustand;
}
Gesundheitszustand getGesundheitszustand() {
  return gesundheitszustand;
}
 // Methode zum Speichern alter KBB-Ergebnisse
  void archiviereKbbErgebnisse() {
    if (kbbErgebnisse.isNotEmpty) {
      alteKbbErgebnisse[DateTime.now()] = Map.from(kbbErgebnisse);
      kbbErgebnisse.clear();
    }
  }

  // Methode zum Speichern alter MRT-Bilder
  void archiviereMrtBilder() {
    if (mrtBilder.isNotEmpty) {
      alteMrtBilder[DateTime.now()] = Map.from(mrtBilder);
      mrtBilder.clear();
    }
  }





}
enum Gesundheitszustand { gut, leichtReduziert, reduziert, schlecht,nicht }

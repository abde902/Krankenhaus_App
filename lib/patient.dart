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
    return mrtBilder.values.any((bilderListe) => bilderListe.isEmpty);
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
// Convert a Patient object to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vorname': vorname,
      'nachname': nachname,
      'geschlecht': gechlecht,
      'geburtsdatum': geburtsdatum.toIso8601String(),
      'entlassen': entlassen,
      'zimmerNummer': zimmerNummer,
      'diagnosen': diagnosen,
      'MRT': MRT,
      'blutuntersuchung': blutuntersuchung,
      'mrtfertig': mrtfertig,
      'blutfertig': blutfertig,
      'mrts': mrts,
      'mrtBilder': mrtBilder,
      'kbbErgebnisse': kbbErgebnisse,
      'krankenverlauf': krankenverlauf.map((key, value) => MapEntry(key.toIso8601String(), value)),
      'gesundheitszustand': gesundheitszustand.index,
      'alteKbbErgebnisse': alteKbbErgebnisse.map((key, value) => MapEntry(key.toIso8601String(), value)),
      'alteMrtBilder': alteMrtBilder.map((key, value) => MapEntry(key.toIso8601String(), value)),
    };
  }

  // Create a Patient object from a Map
factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      vorname: json['vorname'],
      nachname: json['nachname'],
      gechlecht: json['geschlecht'],
      geburtsdatum: DateTime.parse(json['geburtsdatum']),
      entlassen: json['entlassen'],
      zimmerNummer: json['zimmerNummer'],
      MRT: json['MRT'],
      blutuntersuchung: json['blutuntersuchung'],
      mrtfertig: json['mrtfertig'],
      blutfertig: json['blutfertig'],
      gesundheitszustand: Gesundheitszustand.values[json['gesundheitszustand']],
      initialDiagnosen: List<String>.from(json['diagnosen']),
      initialMRTs: List<String>.from(json['mrts']),
    )
    ..mrtBilder = (json['mrtBilder'] as Map<String, dynamic>).map((key, value) => MapEntry(key, List<String>.from(value)))
    ..kbbErgebnisse = Map<String, double>.from(json['kbbErgebnisse'])
    ..krankenverlauf = (json['krankenverlauf'] as Map<String, dynamic>).map((key, value) => MapEntry(DateTime.parse(key), value))
    ..alteKbbErgebnisse = (json['alteKbbErgebnisse'] as Map<String, dynamic>).map((key, value) => MapEntry(DateTime.parse(key), Map<String, double>.from(value)))
    ..alteMrtBilder = (json['alteMrtBilder'] as Map<String, dynamic>).map((key, value) => MapEntry(DateTime.parse(key), (value as Map<String, dynamic>).map((k, v) => MapEntry(k, List<String>.from(v)))));
  }




}
enum Gesundheitszustand { gut, leichtReduziert, reduziert, schlecht,nicht }

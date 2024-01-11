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
  Map<String, List<String>> mrtBilder = {};
  

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
  void removeMRTImage(String imageName) {
    mrts.remove(imageName);
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
}

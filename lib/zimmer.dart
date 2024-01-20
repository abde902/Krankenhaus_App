class Zimmer {
  final int nummer;
  bool istBelegt;

  Zimmer({required this.nummer,  this.istBelegt=false });
  Map<String, dynamic> toJson() {
    return {
      'nummer': nummer,
      'istBelegt': istBelegt,
    };
  }

  factory Zimmer.fromJson(Map<String, dynamic> json) {
    return Zimmer(
      nummer: json['nummer'],
      istBelegt: json['istBelegt'],
    );
  }



}

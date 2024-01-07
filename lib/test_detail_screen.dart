import 'package:flutter/material.dart';


class TestDetailPage extends StatefulWidget {
  final int testId; // oder eine andere Identifikation für den Test

  TestDetailPage({required this.testId});

  @override
  _TestDetailPageState createState() => _TestDetailPageState();
}

class _TestDetailPageState extends State<TestDetailPage> {
  String testErgebnis = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Details'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          // Hier können Sie Details zu Ihrem Test anzeigen und Eingaben tätigen
          Text('Test ID: ${widget.testId}'),
          TextField(
            onChanged: (value) {
              testErgebnis = value;
            },
            decoration: InputDecoration(labelText: 'Ergebnis einfügen'),
          ),
          ElevatedButton(
            onPressed: () {
              // Logik zum Speichern des Ergebnisses
            },
            child: Text('Ergebnis speichern'),
          ),
        ],
      ),
    );
  }
}

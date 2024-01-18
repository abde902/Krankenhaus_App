import 'package:flutter/material.dart';
import 'dash_arzt.dart';
import 'dash_labor.dart';
import 'dash_admin.dart';
import 'daten_patient.dart'; // Stellen Sie sicher, dass dieser Import korrekt ist

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused) {
      try {
        await DatenVerwaltung().writeData();
        print("Daten erfolgreich gespeichert.");
      } catch (e) {
        print("Fehler beim Speichern der Daten: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hospital App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 84, 149, 81),
        ),
        useMaterial3: true,
        textTheme: const TextTheme(
          headline6: TextStyle(color: Colors.green),
          bodyText2: TextStyle(color: Color.fromARGB(255, 158, 158, 158)),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void navigateToArztDashboard() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ArztDashboard()));
  }

  void navigateToLabDashboard() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LabDashboard()));
  }

  void navigateToAdminDashboard() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AdminDashboard()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/304.jpg'), 
            fit: BoxFit.cover, 
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 60),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary:Color.fromARGB(255, 94, 221, 101),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: navigateToArztDashboard,
                child: const Text('Arzt Dashboard'),
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary:Color.fromARGB(255, 94, 221, 101),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: navigateToAdminDashboard,
                child: const Text('Administrator Dashboard'),
              ),
              const SizedBox(height:60),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 94, 221, 101),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: navigateToLabDashboard,
                child: const Text('Labor Dashboard'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

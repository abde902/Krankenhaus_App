// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dash_arzt.dart';
import 'dash_labor.dart';
import 'dash_admin.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MEDICONNECT',
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
  const LoginScreen({super.key});

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
            image: AssetImage('assets/images/hin.jpg'), 
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
                  primary:Color.fromARGB(200, 98, 12, 8),
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: null,
                child: const Text('Willkommen bei MEDICONNECT - Der Weg zu Gesundheit und Verbundenheit'),
              ),
              const SizedBox(height: 80),


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
                child: const Text('Arztportal'),
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
                child: const Text('Verwaltungsportal'),
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
                child: const Text('Laborportal'),
              ),
             
             
            ],
          ),
        ),
      ),
    );
  }
}









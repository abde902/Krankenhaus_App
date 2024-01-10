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
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? selectedRole = 'Administrator';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void navigateToDashboard() {
    if (selectedRole == 'Arzt') {
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  ArztDashboard()));
    } else if (selectedRole == 'Labor') {
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  LabDashboard()));
    } else if (selectedRole == 'Administrator') {
      Navigator.push(context, MaterialPageRoute(builder: (context) =>   AdminDashboard()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color.fromARGB(255, 36, 116, 165), Color.fromARGB(255, 50, 164, 55)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView(
            children: <Widget>[
              const SizedBox(height: 40),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Select Role',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_outline),
                ),
                value: selectedRole,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedRole = newValue;
                  });
                },
                items: const <String>['Arzt', 'Administrator', 'Labor']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 61, 162, 66),
                  onPrimary: Color.fromARGB(166, 255, 255, 255),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: navigateToDashboard,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}







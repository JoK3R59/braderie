import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    final String email = usernameController.text;
    final String password = passwordController.text;

    final response = await http.post(
      Uri.parse('http://192.168.1.17:3000/login'),
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      _navigateToHome();
    } else {
      print('Erreur de connexion /!\\');
    }
  }

  _navigateToHome() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  _navigateToCreate() {
    Navigator.pushNamed(context, '/create');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page de connexion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Adresse Email'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Mot de passe'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: login,
              child: const Text('Se connecter'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _navigateToCreate,
              child: const Text('Créer un compte'),
            ),
          ],
        ),
      ),
    );
  }
}
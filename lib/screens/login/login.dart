import 'package:flutter/material.dart';

import '../../services/login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final AuthService _authService = AuthService();

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
              onPressed: () {
                _authService.loginUser(
                  usernameController.text,
                  passwordController.text,
                ).then((value) {
                  if (value) {
                    _navigateToHome();
                  } else {
                    print('Erreur de connexion /!\\');
                  }
                });
              },
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
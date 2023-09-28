import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'api.dart';

class AuthService {
  final ApiService _apiService = ApiService();
  final storage = const FlutterSecureStorage();

  Future<bool> loginUser(String email, String password) async {
        try {
      final response = await _apiService.postData('login', {
        'email': email,
        'password': password,
      });

      if (response['token'] != null) {
        await storage.write(key: 'authToken', value: response['token']);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Erreur de connexion: $e');
      return false;
    }
  }

  Future<int> createUser(String email, String password) async {
    try {
      final response = await _apiService.postData('create', {
        'email': email,
        'password': password,
      });

      // En supposant que votre API renvoie des codes de statut comme indiqué dans votre code d'origine
      if (response == 201) {
        return 1; // Utilisateur créé avec succès
      } else if (response == 409) {
        return 2; // Utilisateur déjà existant
      } else {
        return 0; // Erreur inattendue
      }
    } catch (e) {
      print('Erreur de connexion: $e');
      return 0; // Erreur de connexion
    }
  }
}
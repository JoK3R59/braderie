import '../models/storage_item.dart';
import 'api.dart';

class StorageService {
  final ApiService _apiService = ApiService();

  Future<Storage> fetchStorage(String userId) async {
    try {
      final response = await _apiService.fetchData('storage/$userId');

      if (response.isNotEmpty) {
        final Storage storage = Storage.fromJson(response);
        return storage;
      } else {
        // Gérez le cas où l'objet de stockage est vide ou introuvable
        return Storage(); // Ou renvoyez null ou un autre objet par défaut
      }
    } catch (e) {
      print('StorageService - Erreur de connexion: $e');
      return Storage(); // Ou renvoyez null ou un autre objet par défaut
    }
  }
}
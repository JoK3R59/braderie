import '../models/storage_item.dart';
import 'api.dart';

class StorageService {
  final ApiService _apiService = ApiService();

  Future<Storage> fetchStorage() async {
    try {
      final response = await _apiService.fetchData('storage');

      if (response.isNotEmpty) {
        final Storage storage = Storage.fromJson(response);
        return storage;
      } else {
        // Gérez le cas où l'objet de stockage est vide ou introuvable
        return Storage(); // Ou renvoyez null ou un autre objet par défaut
      }
    } catch (e) {
      return Storage(); // Ou renvoyez null ou un autre objet par défaut
    }
  }
}
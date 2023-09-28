import '../models/storage_item.dart';
import 'api.dart';

class StorageService {
  final ApiService _apiService = ApiService();

  Future<List<Storage>> fetchStorages(String userId) async {

    final response = await _apiService.fetchData('storage/$userId');
    print(response);
    try {
      final response = await _apiService.fetchData('storage/$userId');

      final List<dynamic> storagesJson = response['storages'] ?? [];
      final List<Storage> storages =
          storagesJson.map((e) => Storage.fromJson(e)).toList();

      return storages;
    } catch (e) {
      print('Erreur de connexion: $e');
      return [];
    }
  }
}
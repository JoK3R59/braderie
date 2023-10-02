import '../models/storage_item.dart';
import 'api.dart';

class StorageService {
  final ApiService _apiService = ApiService();

  Future<Storage> fetchStorage() async {
    print('fetchStorage - fetchStorage');
    try {
      final response = await _apiService.fetchData('storage');

      if (response.isNotEmpty) {
        final Storage storage = Storage.fromJson(response);
        return storage;
      } else {
        return Storage();
      }
    } catch (e) {
      return Storage();
    }
  }

  Future<bool> deleteStorageItem(String objectId) async {
    print('deleteStorageItem');
    try {
      final response = await _apiService.deleteData('storage', objectId);

      if (response) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
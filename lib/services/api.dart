import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://192.168.1.17:3000';
  final storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> fetchData(String endpoint) async {
    String? authToken = await storage.read(key: 'authToken');
    String? authUser = await storage.read(key: 'userId');
    final response = await http.get(
      Uri.parse('$baseUrl/$endpoint/$authUser'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future<Map<String, dynamic>> postData(
      String endpoint, Map<String, dynamic> body
      ) async {
    String? authToken = await storage.read(key: 'authToken');
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      body: json.encode(body),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to send data');
    }
  }

  // deleteData
  Future<bool> deleteData(String endpoint, String objectId) async {
    String? authToken = await storage.read(key: 'authToken');
    String? authUser = await storage.read(key: 'userId');
    final response = await http.delete(
      Uri.parse('$baseUrl/$endpoint/$authUser/$objectId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      print('Deleted data successfully');
      return true;
    } else {
      throw Exception('Failed to delete data');
    }
  }

}

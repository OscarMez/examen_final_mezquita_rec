import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Service extends ChangeNotifier {
  final String _baseUrl = "ca8e24635294d8580534.free.beeceptor.com";
  final String _endpoint = "/api/users";
  List<Map<String, dynamic>> users = [];

  Service() {
    loadUsers();
  }

  Future<void> loadUsers() async {
    final url = Uri.https(_baseUrl, _endpoint);
    final response = await http.get(url);

    print("URL: $url");
    print("Response status code: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      users = jsonResponse.cast<Map<String, dynamic>>();
      print("Users loaded: $users");
    } else {
      throw Exception('Error al cargar los usuarios');
    }

    notifyListeners();
  }

  Future<void> createUser(Map<String, dynamic> user) async {
    final url = Uri.https(_baseUrl, _endpoint);
    final response = await http.post(
      url,
      body: json.encode(user),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 201) {
      await loadUsers();
      notifyListeners();
    } else {
      throw Exception('Error al crear el usuario');
    }
  }

  Future<void> updateUser(String id, Map<String, dynamic> user) async {
    final url = Uri.https(_baseUrl, '$_endpoint/$id');
    final response = await http.put(
      url,
      body: json.encode(user),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      await loadUsers();
    } else {
      throw Exception('Error al actualizar el usuario');
    }
  }

  Future<void> deleteUser(String id) async {
    final url = Uri.https(_baseUrl, '$_endpoint/$id');
    final response = await http.delete(url);

    if (response.statusCode == 200) {
      await loadUsers();
    } else {
      throw Exception('Error al eliminar el usuario');
    }
  }
}
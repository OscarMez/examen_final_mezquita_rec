import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> user;

  DetailScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalls Usuari')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${user['id'] ?? 'Sense ID'}'),
            Text('Nom: ${user['name'] ?? 'Sense nombre'}'),
            Text('Llinatge: ${user['last_name'] ?? 'Sense apellido'}'),
            Text('Email: ${user['email'] ?? 'Sense email'}'),
            Text('Telefon: ${user['phone'] ?? 'Sense Telèfon'}'),
            Text('Adreça: ${user['address'] ?? 'Sense Direcció'}'),
            SizedBox(height: 20),
            if (user['photo'] != null && user['photo'].isNotEmpty)
              Image.network(user['photo']),
          ],
        ),
      ),
    );
  }
}
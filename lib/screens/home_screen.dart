import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/services.dart'; // Importa el servicio

class HomeScreen extends StatelessWidget {
  // Método para cerrar sesión
  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username'); // Eliminar el nombre de usuario
    await prefs.remove('password'); // Eliminar la contraseña
    await prefs.remove('rememberMe'); // Eliminar la opción "Remember me"

    // Navegar a la pantalla de login
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<Service>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context), // Cerrar sesión
          ),
        ],
      ),
      body: userService.users.isEmpty
          ? Center(child: Text('No hi ha usuaris disponibles'))
          : ListView.builder(
              itemCount: userService.users.length,
              itemBuilder: (context, index) {
                final user = userService.users[index];
                return ListTile(
                  title: Text(user['id']?.toString() ?? 'Sense ID'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user['name'] ?? 'Sense nom'),
                      Text(user['email'] ?? 'Sense email'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => userService.deleteUser(user['id'].toString()),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/userDetail',
                      arguments: user,
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddUserDialog(context, userService);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Diálogo para agregar un nuevo usuario
  void _showAddUserDialog(BuildContext context, Service userService) {
    final _idController = TextEditingController();
    final _nameController = TextEditingController();
    final _lastNameController = TextEditingController();
    final _emailController = TextEditingController();
    final _phoneController = TextEditingController();
    final _addressController = TextEditingController();
    final _photoController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Afegir usuari'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _idController,
                  decoration: InputDecoration(labelText: 'ID'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Nom'),
                ),
                TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(labelText: 'Cognom'),
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Telèfon'),
                ),
                TextField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Adreça'),
                ),
                TextField(
                  controller: _photoController,
                  decoration: InputDecoration(labelText: 'URL de la foto'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel·lar'),
            ),
            TextButton(
              onPressed: () {
                final newUser = {
                  'id': _idController.text,
                  'name': _nameController.text,
                  'last_name': _lastNameController.text,
                  'email': _emailController.text,
                  'phone': _phoneController.text,
                  'address': _addressController.text,
                  'photo': _photoController.text,
                };
                userService.createUser(newUser);
                Navigator.pop(context);
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}
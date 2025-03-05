import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart'; // Importa la pantalla de inicio de sesión
import 'screens/home_screen.dart'; // Importa la pantalla principal
import 'screens/detail_screen.dart'; // Importa la pantalla de detalles del usuario
import 'services/services.dart'; // Importa el servicio

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Service()), // Provee el UserService
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CRUD amb Beeceptor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login', // Ruta inicial
      routes: {
        '/login': (context) => LoginScreen(), // Pantalla de inicio de sesión
        '/home': (context) => HomeScreen(), // Pantalla principal
        '/userDetail': (context) => DetailScreen(
              user: ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>,
            ), // Pantalla de detalles del usuario
      },
    );
  }
}
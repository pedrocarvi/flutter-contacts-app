import 'package:chatapp/services/api_service.dart';
import 'package:chatapp/services/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/models/login_model.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 10, 10, 10),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                'AgendApp',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70),
              ),
            ),
            const SizedBox(height: 12),
            const Center(
                child: Text(
              '¡Con nuestra app podrás guardar todos los medios de contacto de tus familiares, amigos, socios y más!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
              ),
            )),
            const SizedBox(height: 20),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                  labelText: 'Usuario',
                  labelStyle:
                      TextStyle(color: Color.fromARGB(200, 255, 255, 255))),
              style: const TextStyle(color: Color.fromARGB(200, 255, 255, 255)),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle:
                      TextStyle(color: Color.fromARGB(200, 255, 255, 255))),
              style: const TextStyle(color: Color.fromARGB(200, 255, 255, 255)),
              obscureText: true,
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                _login(context);
              },
              child: const Text('Iniciar Sesión'),
            ),
            const SizedBox(height: 32.0),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text('¿Todavia no tenes una cuenta? ¡Registrate!',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    );
  }

  void _login(BuildContext context) async {
    // Agarro los valores de los campos y los guardo en estas variables
    String username = usernameController.text;
    String password = passwordController.text;

    // Creo un LoginModel con la información de los campos.
    LoginModel loginData = LoginModel(userName: username, password: password);

    try {
      // Respuesta del endpoint de Login
      String token = await _apiService.login(loginData);
      // Guardo token - AuthProviders
      Provider.of<AuthProvider>(context, listen: false).setToken(token);
      print('Token: $token');
      Navigator.pushNamed(context, '/contacts');
    } catch (e) {
      print('Error en el login: $e');
    }
  }
}

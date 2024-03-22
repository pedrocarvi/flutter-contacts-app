import 'package:chatapp/models/signup_model.dart';
import 'package:chatapp/services/api_service.dart';
import 'package:chatapp/services/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 10, 10, 10),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                'Registrate',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white70),
              ),
            ),
            const SizedBox(height: 12),
            const Center(
                child: Text(
              '¡Demora menos de 1 minuto!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
              ),
            )),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  labelText: 'Nombre',
                  labelStyle:
                      TextStyle(color: Color.fromARGB(200, 255, 255, 255))),
              style: const TextStyle(color: Color.fromARGB(200, 255, 255, 255)),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(
                  labelText: 'Apellido',
                  labelStyle:
                      TextStyle(color: Color.fromARGB(200, 255, 255, 255))),
              style: const TextStyle(color: Color.fromARGB(200, 255, 255, 255)),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                  labelText: 'Nombre de usuario',
                  labelStyle:
                      TextStyle(color: Color.fromARGB(200, 255, 255, 255))),
              style: const TextStyle(color: Color.fromARGB(200, 255, 255, 255)),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: 'Correo electronico',
                  labelStyle:
                      TextStyle(color: Color.fromARGB(200, 255, 255, 255))),
              style: const TextStyle(color: Color.fromARGB(200, 255, 255, 255)),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle:
                      TextStyle(color: Color.fromARGB(200, 255, 255, 255))),
              style: const TextStyle(color: Color.fromARGB(200, 255, 255, 255)),
              obscureText: true,
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                _signup(context);
              },
              child: Text('Registrate'),
            ),
            const SizedBox(height: 32.0),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text('Ya tengo una cuenta',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    );
  }

  void _signup(BuildContext context) async {
    String name = nameController.text;
    String lastname = lastNameController.text;
    String email = emailController.text;
    String username = usernameController.text;
    String password = passwordController.text;

    SignUpModel signUpData = SignUpModel(
        name: name,
        lastName: lastname,
        email: email,
        userName: username,
        password: password);

    try {
      print('Sign up data ${signUpData.name}');
      print('Sign up data ${signUpData.lastName}');
      print('Sign up data ${signUpData.email}');
      print('Sign up data ${signUpData.userName}');
      print('Sign up data ${signUpData.password}');

      ApiService apiService = ApiService();
      String token = await apiService.signup(signUpData);

      print('Registro exitoso. Token: $token');

      Provider.of<AuthProvider>(context, listen: false).setToken(token);

      Navigator.pushNamed(context, '/contacts');
      // Guardo token - AuthProviders
    } catch (e) {
      print('Error en el sign up: $e');
      // Mostrar un mensaje de error al usuario:
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error en el login')));
    }
  }
}

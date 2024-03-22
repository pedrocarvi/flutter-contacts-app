import 'dart:convert';
import 'package:chatapp/models/contact_model.dart';
import 'package:chatapp/models/login_model.dart';
import 'package:chatapp/models/signup_model.dart';
import 'package:chatapp/services/auth_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ApiService {
  Future<String> login(LoginModel loginData) async {
    final url =
        Uri.parse('https://localhost:7027/api/authentication/authenticate');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userName': loginData.userName,
        'password': loginData.password,
      }),
    );

    // print('Respuesta del servidor: ${response.body}');

    if (response.statusCode == 200) {
      return response.body;
    } else {
      print('Error en el login: ${response.statusCode}');
      throw Exception('Error en el login');
    }
  }

  Future<String> signup(SignUpModel userData) async {
    final url = Uri.parse('https://localhost:7027/api/User');

    // print('Request body: ${jsonEncode(userData.toJson())}');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userData.toJson()),
    );

    if (response.statusCode == 201) {
      return _loginAfterSignup(userData.userName, userData.password);
    } else {
      // Error en el registro
      print('Error en el registro: ${response.statusCode}');
      throw Exception('Error en el registro');
    }
  }

  Future<String> _loginAfterSignup(String username, String password) async {
    // print('username login after su $username');
    // print('password login after su $password');
    final url =
        Uri.parse('https://localhost:7027/api/authentication/authenticate');

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userName': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      print(
          'Error en el inicio de sesión después del registro: ${response.statusCode}');
      throw Exception('Error en el inicio de sesión después del registro');
    }
  }

  Future<List<ContactModel>> getContacts(BuildContext context) async {
    List<ContactModel> contacts = [];

    String? token = Provider.of<AuthProvider>(context, listen: false).token;
    if (token != null) {
      final url = Uri.parse('https://localhost:7027/api/Contact');
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        contacts = data.map((json) => ContactModel.fromJson(json)).toList();
      } else {
        print("Error en get contacts");
      }
    }

    return contacts;
  }
}

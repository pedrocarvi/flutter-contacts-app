import 'package:chatapp/screens/contact.dart';
import 'package:chatapp/screens/contacts.dart';
import 'package:chatapp/screens/login.dart';
import 'package:chatapp/screens/signup.dart';
import 'package:chatapp/services/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: '/',
        routes: {
          '/': (context) => Login(key: UniqueKey()),
          '/signup': (context) => SignUp(),
          '/contacts': (context) {
            final isAuthenticated =
                Provider.of<AuthProvider>(context).token != null;
            return isAuthenticated ? Contacts() : Login(key: UniqueKey());
          },
          '/contact': (context) {
            final isAuthenticated =
                Provider.of<AuthProvider>(context).token != null;
            return isAuthenticated ? Contact() : Login(key: UniqueKey());
          },
        },
      ),
    );
  }
}

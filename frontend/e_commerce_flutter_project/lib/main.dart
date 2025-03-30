import 'package:e_commerce_flutter_project/authentication/presentation/screens/register_screen.dart';
import 'package:e_commerce_flutter_project/generate_route.dart';
import 'package:e_commerce_flutter_project/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const RegisterScreen(),
      theme: lightTheme,
      onGenerateRoute: generateRoute,
      initialRoute: '/register',
      title: 'Flutter Demo',);
  }
  
}
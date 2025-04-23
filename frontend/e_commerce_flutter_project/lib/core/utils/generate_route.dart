import 'package:e_commerce_flutter_project/features/authentication/presentation/screens/login_screen.dart';
import 'package:e_commerce_flutter_project/features/authentication/presentation/screens/register_screen.dart';
import 'package:e_commerce_flutter_project/features/products_feature/presentation/screens/home_page.dart';
import 'package:flutter/material.dart';

MaterialPageRoute generateRoute(RouteSettings settings){
  // final args = settings.arguments;
  switch(settings.name){
    case '/loading':
      return MaterialPageRoute(builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ));
    case '/login':
      return MaterialPageRoute(builder: (context) => const LoginScreen());
      case '/register':
      return MaterialPageRoute(builder: (context) => const RegisterScreen());
      case '/home':
      return MaterialPageRoute(builder: (context) => const HomePage());
  default:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
  }
  
}
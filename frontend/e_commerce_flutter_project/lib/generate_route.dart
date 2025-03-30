import 'package:e_commerce_flutter_project/authentication/presentation/screens/register_screen.dart';
import 'package:e_commerce_flutter_project/login_page.dart';
import 'package:flutter/material.dart';

MaterialPageRoute generateRoute(RouteSettings settings){
  // final args = settings.arguments;
  switch(settings.name){
    case '/login':
      return MaterialPageRoute(builder: (context) => const LoginPage());
      case '/register':
      return MaterialPageRoute(builder: (context) => const RegisterScreen());
  default:
      return MaterialPageRoute(builder: (context) => const LoginPage());
  } 
  
}
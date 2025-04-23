import 'package:e_commerce_flutter_project/core/di.dart';
import 'package:e_commerce_flutter_project/features/authentication/domain/repo/auth_repo.dart';
import 'package:e_commerce_flutter_project/features/authentication/presentation/screens/register_screen.dart';
import 'package:e_commerce_flutter_project/features/ensure_logged_in_feature/cubit/ensure_logged_in_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/utils/generate_route.dart';
import '../core/theme/theme.dart';
import 'package:flutter/material.dart';

void main() {
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EnsureLoggedInCubit(authRepo: getIt<AuthRepo>()),
      child: BlocListener<EnsureLoggedInCubit, EnsureLoggedInState>(
        listener: (context, state) {
          if (state is EnsureLoggedInSuccess) {
            if (state.isLoggedIn) {
              Navigator.pushReplacementNamed(context, '/home');
            } else {
              Navigator.pushReplacementNamed(context, '/login');
            }
          } else if (state is EnsureLoggedInError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: MaterialApp(
          theme: lightTheme,
          onGenerateRoute: generateRoute,
          initialRoute: '/loading',
          title: 'Flutter Demo',
        ),
      ),
    );
  }
}

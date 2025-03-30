import 'package:e_commerce_flutter_project/authentication/presentation/widgets/custom_text_field.dart';
import 'package:e_commerce_flutter_project/authentication/presentation/widgets/outlined_button.dart';
import 'package:e_commerce_flutter_project/authentication/presentation/widgets/primary_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  String? emailErrorText;
  String? passwordErrorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Already have an account?'),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text(
                'Sign In',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          reverse: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create Your Account',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Text(
                "Which part of the country do you call home?",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _nameController,
                      label: "Name",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      controller: _emailController,
                      label: "Email",
                      errorText: emailErrorText,
                      onChanged: _validateEmail,
                    ),
                    CustomTextField(
                      controller: _passwordController,
                      label: "Password",
                      obscureText: true,
                      errorText: passwordErrorText,
                      onChanged: _validatePassword,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(value: false, onChanged: (value) {}),
                  RichText(
                    text: TextSpan(
                      text: 'I accept ',
                      style: Theme.of(context).textTheme.bodySmall,
                      children: [
                        TextSpan(
                          text: 'Terms & Privacy Policy',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, "/terms");
                            },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              PrimaryButton(
                label: "Register",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              OutlinedButtonCustom(
                label: "Continue with Google",
                icon: Icons.g_mobiledata_outlined,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validatePassword(String value) {
    if (value.isEmpty) {
      setState(() => passwordErrorText = 'Please enter your password');
    } else if (value.length < 8) {
      setState(() => passwordErrorText = 'Password must be at least 8 characters long');
    } else {
      final RegExp passwordRegex =
          RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');
      if (!passwordRegex.hasMatch(value)) {
        setState(() => passwordErrorText =
            'Password must contain at least one uppercase letter, one lowercase letter, and one number');
      } else {
        setState(() => passwordErrorText = null);
      }
    }
  }

  void _validateEmail(String value) {
    if (value.isEmpty) {
      setState(() => emailErrorText = 'Please enter your email address');
    } else {
      final RegExp emailRegex =
          RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      if (!emailRegex.hasMatch(value)) {
        setState(() => emailErrorText = 'Please enter a valid email address');
      } else {
        setState(() => emailErrorText = null);
      }
    }
  }
}

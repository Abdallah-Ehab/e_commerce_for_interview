import 'package:e_commerce_flutter_project/core/utils/validators/validator.dart';

import '../../../../../core/di.dart';
import 'package:e_commerce_flutter_project/features/authentication/domain/usecases/register_use_case.dart';
import 'package:e_commerce_flutter_project/features/authentication/presentation/cubit/cubit/register_cubit.dart';
import 'package:e_commerce_flutter_project/features/authentication/presentation/widgets/custom_text_field.dart';
import 'package:e_commerce_flutter_project/features/authentication/presentation/widgets/loading_button.dart';
import 'package:e_commerce_flutter_project/features/authentication/presentation/widgets/or_widget.dart';
import 'package:e_commerce_flutter_project/features/authentication/presentation/widgets/outlined_button.dart';
import 'package:e_commerce_flutter_project/features/authentication/presentation/widgets/primary_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  String? name;
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create:
          (context) => RegisterCubit(
            registerUseCase: getIt<RegisterUseCase>(),
          ),
      child: Builder(
        builder:
            (context) => Scaffold(
              resizeToAvoidBottomInset: true,
              persistentFooterAlignment: AlignmentDirectional.bottomCenter,
              persistentFooterButtons: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text(
                          'Sign In',
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              body: BlocListener<RegisterCubit, RegisterState>(
                listener: (context, state) {
                  if (state is RegisterLoading) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('Loading...')));
                  } else if (state is RegisterSuccess) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.message)));
                    Navigator.pushNamed(context, '/login');
                  } else if (state is RegisterFailure) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.error)));
                  }
                },
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    reverse: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
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
                          autovalidateMode: AutovalidateMode.always,
                          
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
                                onChanged: (value) {
                                  setState(() {
                                    name = value;
                                  });
                                },
                              ),
                              CustomTextField(
                                validator: Validator.validateEmail,
                                controller: _emailController,
                                label: "Email",
                                errorText: emailErrorText,
                                onChanged: (value) {
                                  setState(() {
                                    email = value;
                                  });
                                },
                              ),
                              CustomTextField(
                                validator: Validator.validatePassword,
                                controller: _passwordController,
                                label: "Password",
                                obscureText: true,
                                errorText: passwordErrorText,
                                onChanged: (value) {
                                  setState(() {
                                    password = value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                    recognizer:
                                        TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.pushNamed(
                                              context,
                                              "/terms",
                                            );
                                          },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        BlocBuilder<RegisterCubit, RegisterState>(
                          builder: (context, state) {
                            if (state is RegisterLoading) {
                              return const LoadingButton();
                            } else if (state is RegisterFailure) {
                              return PrimaryButton(
                                label: "gay",
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<RegisterCubit>().register(name,email,password);
                                  }
                                },
                              );
                            } else {
                              return PrimaryButton(
                                label: "Register",
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<RegisterCubit>().register(name,email,password);
                                  }
                                },
                              );
                            }
                          },
                        ),
                        OrWidget(),
                        OutlinedButtonCustom(
                          label: "Continue with Google",
                          icon: FaIcon(
                            FontAwesomeIcons.google,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {},
                        ),
                        const SizedBox(height: 10),
                        OutlinedButtonCustom(
                          label: "Continue with Facebook",
                          icon: FaIcon(
                            FontAwesomeIcons.facebook,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {},
                        ),
                        const SizedBox(height: 10),
                        OutlinedButtonCustom(
                          label: "Continue with apple",
                          icon: FaIcon(
                            FontAwesomeIcons.apple,
                            color: Colors.blueGrey,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      ),
    );
  }
  }
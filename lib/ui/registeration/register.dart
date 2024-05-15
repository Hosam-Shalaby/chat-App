// ignore_for_file: depend_on_referenced_packages, unused_import

import 'package:chat/base/base.dart';
import 'package:chat/ui/Home/home_screen.dart';
import 'package:chat/ui/login/login.dart';
import 'package:chat/ui/utls/validation_utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'registraion_view_model.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'Register Screen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState
    extends BaseState<RegisterScreen, RegistrationViewModel>
    implements RegistrationNavigator {
  bool obscure = true;
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var userNameController = TextEditingController();
  var fullNameController = TextEditingController();
  @override
  RegistrationViewModel initViewModel() {
    return RegistrationViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegistrationViewModel>(
      create: (context) => viewModel,
      child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.fill)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: const Text('Create Account'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 5,
                    ),
                    TextFormField(
                      controller: fullNameController,
                      validator: (text) {
                        if (text!.trim().isEmpty) {
                          return 'please enter full name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'Full Name'),
                    ),
                    TextFormField(
                      controller: userNameController,
                      validator: (text) {
                        if (text!.trim().isEmpty) {
                          return 'please enter User name';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'User Name'),
                    ),
                    TextFormField(
                      controller: emailController,
                      validator: (text) {
                        if (text!.trim().isEmpty) {
                          return 'please enter an Email';
                        }
                        if (!ValidationUtils.isValidEmail(text)) {
                          return 'please enter a valid email';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'Email '),
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (text) {
                        if (text!.trim().isEmpty) {
                          return 'please enter Password';
                        }
                        if (text.length < 6) {
                          return 'Password should be at least 6 characters';
                        }
                        return null;
                      },
                      obscureText: obscure,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: InkWell(
                            child: Icon(obscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onTap: () {
                              setState(() {
                                obscure = !obscure;
                              });
                            },
                          )),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          createAccountClicked();
                        },
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(16))),
                        child: const Text(
                          'Create Account',
                          style: TextStyle(fontSize: 15),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, LoginScreen.routeName);
                        },
                        child: const Text('Already have an account?')),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  void createAccountClicked() async {
    if (formKey.currentState!.validate()) {
      viewModel.register(emailController.text, passwordController.text,
          fullNameController.text, userNameController.text);
    }
  }


  @override
  void goToHome() {
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
  
 
}

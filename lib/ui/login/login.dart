// ignore_for_file: depend_on_referenced_packages, unused_import

import 'package:chat/base/base.dart';
import 'package:chat/ui/Home/home_screen.dart';
import 'package:chat/ui/login/login_view_model.dart';
import 'package:chat/ui/registeration/register.dart';
import 'package:chat/ui/utls/dialog_utls.dart';
import 'package:chat/ui/utls/validation_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login Screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen, LoginViewModel>
    implements LoginNavigator {
  bool obscure = true;
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  LoginViewModel initViewModel() {
    return LoginViewModel();
  }

  @override
  Widget build(BuildContext context) {
    // viewModel.checkLoggedInUser();
    return ChangeNotifierProvider<LoginViewModel>(
      create: (_) => viewModel,
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
                          signInClicked();
                        },
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(16))),
                        child: const Text(
                          'Login Now',
                          style: TextStyle(fontSize: 15),
                        )),
                    const SizedBox(
                      height: 50,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, RegisterScreen.routeName);
                        },
                        child: const Text('Don\'t have an account? Register')),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  void signInClicked() {
    if (formKey.currentState!.validate()) {
      viewModel.login(emailController.text, passwordController.text);
    }
  }

  @override
  void goToHome() {
    Navigator.pushReplacementNamed(context, HomeScreen.routeName);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/bloc/user/bloc/user_bloc.dart';
import 'package:shopping_cart/services/auth_service.dart';

import '../model/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 55),
            child: const Center(
              child: Image(
                width: 100,
                image: NetworkImage(
                    "https://media-s3-us-east-1.ceros.com/cambridge/images/2021/10/21/08ab635d51a5dc4d9e34cd6abcd77498/earth.png"),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: const Center(
                child: Text(
              "Welcome to the dictionary world",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            )),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: const Center(
                child: Image(
              image: NetworkImage(
                  "https://www.kindpng.com/picc/m/146-1465439_cartoon-people-work-png-transparent-png.png"),
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      hintText: "Email",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 1,
                        color: Colors.blue.shade400,
                      )),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                        width: 1,
                        color: Colors.blue.shade400,
                      )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: TextFormField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        hintText: "Password",
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          width: 1,
                          color: Colors.blue.shade400,
                        )),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          width: 1,
                          color: Colors.blue.shade400,
                        )),
                      ),
                    ),
                  ),
                  // padding: EdgeInsets.only(top: 20),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(children: [
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.blue.shade400)),
                          child: const Text("Login"),
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            String email = _emailController.text;
                            String password = _passwordController.text;
                            BlocProvider.of<UserBloc>(context).add(
                                UserLoginEvent(
                                    username: email, password: password));
                            Navigator.pushNamed(context, '/home');
                          },
                        ),
                      ),
                    ]),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

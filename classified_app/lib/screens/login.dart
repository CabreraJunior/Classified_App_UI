import 'package:classified_app/models/log_model.dart';
import 'package:classified_app/services/auth_service.dart';
import 'package:flutter/material.dart';

import '../navigation/const_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final LoginModel _logModel = LoginModel();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
          children: [
            Expanded(
              child: Image.asset(
                "assets/app.jpg",
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Container(
              height: 370,
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      TextFormField(
                          onSaved: (newValue) {
                            setState(() {
                              _logModel.email = newValue;
                            });
                          },
                          style: const TextStyle(fontSize: 18),
                          decoration: const InputDecoration(
                              labelText: "Email Address",
                              border: OutlineInputBorder())),
                      const SizedBox(height: 8),
                      TextFormField(
                          onSaved: (newValue) {
                            setState(() {
                              _logModel.password = newValue;
                            });
                          },
                          style: const TextStyle(fontSize: 18),
                          decoration: const InputDecoration(
                              labelText: "Password",
                              border: OutlineInputBorder())),
                      const SizedBox(height: 12),
                      SizedBox(
                          height: 60,
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () async {
                                _formKey.currentState?.save();
                                await AuthService().login(context, _logModel);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xfff25723)),
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w600),
                              ))),
                      const SizedBox(height: 8),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, registerPage);
                          },
                          child: const Text(
                            "Don't have any account?",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xfff25723)),
                          ))
                    ],
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}

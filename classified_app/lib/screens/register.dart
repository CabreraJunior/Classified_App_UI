import 'package:classified_app/models/reg_model.dart';
import 'package:classified_app/services/auth_service.dart';
import 'package:flutter/material.dart';

import '../navigation/const_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final RegisterModel _regModel = RegisterModel();

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
              height: 400,
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                          onSaved: (newValue) {
                            setState(() {
                              _regModel.name = newValue;
                            });
                          },
                          style: const TextStyle(fontSize: 18, height: 1),
                          decoration: const InputDecoration(
                              labelText: "Full Name",
                              border: OutlineInputBorder())),
                      const SizedBox(height: 8),
                      TextFormField(
                          onSaved: (newValue) {
                            setState(() {
                              _regModel.email = newValue;
                            });
                          },
                          style: const TextStyle(fontSize: 18, height: 1),
                          decoration: const InputDecoration(
                              labelText: "Email Address",
                              border: OutlineInputBorder())),
                      const SizedBox(height: 8),
                      TextFormField(
                          onSaved: (newValue) {
                            setState(() {
                              _regModel.mobile = newValue;
                            });
                          },
                          style: const TextStyle(fontSize: 18, height: 1),
                          decoration: const InputDecoration(
                              labelText: "Mobile Number",
                              border: OutlineInputBorder())),
                      const SizedBox(height: 8),
                      TextFormField(
                          onSaved: (newValue) {
                            setState(() {
                              _regModel.password = newValue;
                            });
                          },
                          style: const TextStyle(fontSize: 18, height: 1),
                          decoration: const InputDecoration(
                              labelText: "Password",
                              border: OutlineInputBorder())),
                      const SizedBox(height: 12),
                      SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () async {
                                _formKey.currentState?.save();
                                await AuthService()
                                    .register(context, _regModel);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xfff25723)),
                              child: const Text(
                                "Register Now",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ))),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, loginPage);
                          },
                          child: const Text(
                            "Already have an account?",
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

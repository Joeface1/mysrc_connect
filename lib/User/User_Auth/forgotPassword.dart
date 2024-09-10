import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mysrc_connect/User/User_Auth/user_login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Regular expression for validating an email
  final RegExp emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  Future<void> _resetPassword(String email) async {
    if (email.isEmpty) {
      _showMessageDialog('Email cannot be empty', false);
      return;
    }

    if (!emailRegExp.hasMatch(email)) {
      _showMessageDialog('Please enter a valid email address', false);
      return;
    }

    try {
      // Check if email exists in Firestore
      final querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // If email exists in Firestore, send password reset email
        await _auth.sendPasswordResetEmail(email: email);
        _showMessageDialog('Password reset email sent to $email', true);
      } else {
        _showMessageDialog('No user found for that email', false);
      }
    } on FirebaseAuthException catch (e) {
      _showMessageDialog('Error: ${e.message}', false);
    } catch (e) {
      _showMessageDialog('An unexpected error occurred: $e', false);
    }
  }

  void _showMessageDialog(String message, bool navigateToLogin) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Password Reset',
            style: TextStyle(
              fontFamily: 'Poppins',
            ),
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (navigateToLogin) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const UserLogIn()),
                  );
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 25,
        title: const Text(
          "Back",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  const Icon(
                    Icons.lock,
                    size: 70,
                    color: Color.fromARGB(255, 255, 0, 0),
                  ),
                  const Text(
                    "Reset Password",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Provide your student email address to receive a link to reset your password.",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  SizedBox(
                    height: 40,
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Student Email Address',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 23,
                  ),
                  ElevatedButton(
                    onPressed: () =>
                        _resetPassword(_emailController.text.trim()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 13, 110, 236),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                      elevation: 3,
                    ),
                    child: const Text(
                      "Send Link",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

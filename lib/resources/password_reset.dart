import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void showPasswordResetDialog( BuildContext context) {
  final TextEditingController resetEmailController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Reset Password'),
        content: TextField(
          controller: resetEmailController,
          decoration: const InputDecoration(
            labelText: 'Enter your email',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final String resetEmail = resetEmailController.text;
              await _sendPasswordResetEmail(resetEmail, context);
              Navigator.of(context).pop();
            },
            child: const Text('Send'),
          ),
        ],
      );
    },
  );
}

Future<void> _sendPasswordResetEmail(String email, BuildContext context) async {
  String message = '';
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    message = 'Password reset email sent';
  } on FirebaseAuthException catch (e) {
    message = 'An error occurred';
    if (e.code == 'user-not-found') {
      message = 'No user found for that email.';
    }
  } finally {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

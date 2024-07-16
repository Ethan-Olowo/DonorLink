import 'package:donorlink/resources/logo_loader.dart';
import 'package:donorlink/views/Splashscreen.dart';
import 'package:donorlink/resources/input_validators.dart';
import 'package:donorlink/resources/password_reset.dart';
import 'package:donorlink/views/retrieve_user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// A login screen that allows users to sign in with their email and password.
class Login extends StatefulWidget {
  const Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  _LoginState();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? errorMessage; // State variable for error messages
  bool isLoading = false; // State variable for loading indicator

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Text('Login'),
        leading: IconButton(
          key: const Key('backButton'),
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    key: Key('logoImage'),
                    image: AssetImage('assets/images/Logo.png'),
                    height: 150,
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          key: const Key('emailField'),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), labelText: 'Email'),
                          controller: emailController,
                          validator: emailValidator,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          key: const Key('passwordField'),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password'),
                          controller: passwordController,
                          obscureText: true,
                          validator: nullValidator,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(errorMessage ?? '',
                              style: const TextStyle(
                                  color: Colors.red)), // Displays error message
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            key: const Key('forgotPasswordButton'),
                            onPressed: () {
                              showPasswordResetDialog(context);
                            },
                            child: const Text('Forgot Password'),
                          ),
                        ),
                        ElevatedButton(
                          key: const Key('signInButton'),
                          onPressed: signIn,
                          child: const Text('Sign In'),
                        ),
                      ],
                    ),
                  ),
                  const Text('Don\'t Have an account?'),
                  ElevatedButton(
                    key: const Key('createAccountButton'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const Splashscreen())); //Forwards User to select User type Screen
                    },
                    child: const Text('Create an Account'),
                  ),
                ],
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: LogoLoader(height: 150),
              ),
            ),
        ],
      ),
    );
  }

  /// Signs in the user with the provided email and password.
  void signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      String email = emailController.text;
      String password = passwordController.text;
      String? userId = await authenticate(email, password);
      setState(() {
        isLoading = false;
      });
      if (userId == null) {
        setState(() {
          errorMessage = 'An unknown error occurred.';
        });
        // All error Messages contain '.' and userIDs do not contain '.'
      } else if (userId.contains('.')) {
        setState(() {
          errorMessage = userId;
        });
      } else {
        setState(() {
          errorMessage = null;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RetrieveUser(userId, context)),
        );
      }
    }
  }
}

/// Authenticates the user with the provided email and password.
///
/// Returns the user's UID if successful, or an error message if not.
Future<String?> authenticate(
  String email,
  String password,
) async {
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return credential.user?.uid;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      return 'Wrong password provided for that user.';
    } else {
      return 'Incorrect email or password.';
    }
  }
}

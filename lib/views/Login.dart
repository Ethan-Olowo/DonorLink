import 'package:donorlink/Controllers/Database.dart';
import 'package:donorlink/Models/Admin.dart';
import 'package:donorlink/Models/Donor.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/Models/Reviewer.dart';
import 'package:donorlink/Models/User.dart' as Us;
import 'package:donorlink/views/Admin/home_page.dart' as Adm;
import 'package:donorlink/views/Donors/home_page.dart' as Don;
import 'package:donorlink/views/Organisations/home_page.dart' as Org;
import 'package:donorlink/views/Register.dart';
import 'package:donorlink/views/Reviewers/home_page.dart' as Rev;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key, required this.userType});

  final String userType;

  @override
  State<Login> createState() => _LoginState(userType: userType);
}

class _LoginState extends State<Login> {
  _LoginState({required this.userType});

  final String userType;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Us.User? user;
  String? errorMessage; // State variable for error messages

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
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text('$userType Login'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage('assets/images/Logo.png')),
              const SizedBox(height: 20),
              // Code functionality to read inputs
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Email'),
                      controller: emailController,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Password'),
                      controller: passwordController,
                      obscureText: true,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the password';
                        }
                        return null;
                      },
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(errorMessage ?? '',
                          style: TextStyle(color: Colors.red)), // Display error message
                    ),
                    // Add this functionality
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('Forgot Password'),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          String email = emailController.text;
                          String password = passwordController.text;
                          String? validity = await Authenticate(email, password);
                          if (validity == null) {
                            setState(() {
                              errorMessage = 'An unknown error occurred.';
                            });
                          } else if (validity.startsWith('No user found') || validity.startsWith('Wrong password')) {
                            setState(() {
                              errorMessage = validity;
                            });
                          } else {
                            setState(() {
                              errorMessage = null;
                            });
                          
                            Database db = Database();
                            user = await db.getUser(validity!);
                            if (user is Donor) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Don.HomePage(
                                          user: user,
                                        )),
                              );
                            } else if (user is Organisation) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Org.HomePage(
                                          user: user,
                                        )),
                              );
                            } else if (user is Reviewer) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Rev.HomePage(
                                          user: user! as Reviewer,
                                        )),
                              );
                            } else if (user is Admin) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Adm.HomePage(
                                          user: user,
                                        )),
                              );
                            }
                          }
                        }
                      },
                      child: const Text('Sign In'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text('Don\'t Have an account?'),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Register(
                              userType: userType,
                            )),
                  );
                },
                child: const Text('Create an Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> Authenticate(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user?.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }else{
        return 'Incorrect email or passpwrd';
      }
    }
  }
}

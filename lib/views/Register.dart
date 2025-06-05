import 'package:donorlink/resources/input_validators.dart';
import 'package:flutter/material.dart';
import 'package:donorlink/Database/database.dart';
import 'package:donorlink/Models/Patient.dart';
import 'package:donorlink/Models/Hospital.dart';
import 'package:donorlink/views/Hospitals/organisation_account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:donorlink/views/Patients/home_page.dart' as pat;

class Register extends StatefulWidget {
  const Register({super.key, required this.userType});
  final String userType;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? _errorMessage;
  bool _isLoading = false; // State variable for loading indicator

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key('appBar'),
        toolbarHeight: 50,
        title: Text('${widget.userType} Registration'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Padding(
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
                            key: const Key('nameField'),
                            controller: _nameController,
                            decoration:
                                const InputDecoration(labelText: 'Name'),
                            validator: nullValidator,
                          ),
                          TextFormField(
                            key: const Key('emailField'),
                            controller: _emailController,
                            decoration:
                                const InputDecoration(labelText: 'Email'),
                            validator: emailValidator,
                          ),
                          TextFormField(
                            key: const Key('phoneField'),
                            controller: _phoneController,
                            decoration:
                                const InputDecoration(labelText: 'Phone'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            key: const Key('passwordField'),
                            controller: _passwordController,
                            decoration:
                                const InputDecoration(labelText: 'Password'),
                            obscureText: true,
                            validator: passwordValidator,
                          ),
                          TextFormField(
                            key: const Key('confirmPasswordField'),
                            controller: _confirmPasswordController,
                            decoration: const InputDecoration(
                                labelText: 'Confirm Password'),
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    if (_errorMessage != null)
                      Padding(
                        key: const Key('errorText'),
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ElevatedButton(
                      key: const Key('registerButton'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          createAccount(
                            _emailController.text,
                            _passwordController.text,
                            _nameController.text,
                            _phoneController.text,
                          );
                        }
                      },
                      child: const Text('Register'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> createAccount(
      String email, String password, String name, String phone) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null; // Clear any previous error message
    });
    if (widget.userType != 'Admin') {
      Database db = Database();
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        dynamic user;

        switch (widget.userType) {
          case 'Donor':
            user = Patient(
                id: credential.user!.uid,
                name: name,
                phone: phone,
                email: email,
                rating: 0);
            db.addUser(user);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => pat.HomePage(
                  user: user,
                ),
              ),
            );
            break;
          case 'Organisation':
            user = Hospital(credential.user!.uid, name, phone, email, null,
                0, 'pending', null, 0);
            db.addUser(user);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrgAccount(
                  org: user,
                ),
              ),
            );
            break;
          
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          if (e.code == 'weak-password') {
            _errorMessage = 'The password provided is too weak.';
          } else if (e.code == 'email-already-in-use') {
            _errorMessage = 'The account already exists for that email.';
          } else {
            _errorMessage = 'An unknown error occurred.';
          }
        });
      } catch (e) {
        setState(() {
          _errorMessage = 'An unknown error occurred.';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _errorMessage = 'Cannot Create Admin Users';
        _isLoading = false;
      });
    }
  }
}

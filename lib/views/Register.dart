import 'dart:ffi';

import 'package:donorlink/Database/Database.dart';
import 'package:donorlink/Models/Donor.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/Models/Reviewer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:donorlink/views/Donors/home_page.dart' as Don;
import 'package:donorlink/views/Organisations/home_page.dart' as Org;
import 'package:donorlink/views/Reviewers/reviewer_account.dart' as Rev;

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
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    if (widget.userType=='Admin'){
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: Text('${widget.userType} Registration'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: const Center(child: Text('Cannot Create an account for this User type'),)
      );  
    }else{
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: Text('${widget.userType} Registration'),
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
                const Image(
                  image: AssetImage('assets/images/Logo.png'),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(labelText: 'Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _phoneController,
                        decoration: const InputDecoration(labelText: 'Phone'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: const InputDecoration(labelText: 'Confirm Password'),
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
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ElevatedButton(
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
      );
      
    }
  }

  Future<void> createAccount(String email, String password, String name, String phone) async {
    if(widget.userType!='Admin'){
      Database db = Database();
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        dynamic user;

        switch(widget.userType) {
          case 'Donor':
            user = Donor(id: credential.user!.uid, name: name, phone: phone, email: email, rating: 0);
            db.addUser(user);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Don.HomePage(
                  user: user,
              )),
            );
            break;
          case 'Organisation':
            user = Organisation(credential.user!.uid, name, phone, email, null, null, 0, null, null, 'pending', null, 0);
            db.addUser(user);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Org.HomePage(
                  user: user,
              )),
            );
            break;
          case 'Reviewer':
            user = Reviewer(credential.user!.uid, name, phone, email, 'pending');
            db.addUser(user);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Rev.ReviewerAccount(
                  reviewer: user,
              )),
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
      }
    } else {
      _errorMessage = 'Cannot Create Admin Users';
    }
  }

}

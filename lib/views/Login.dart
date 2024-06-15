// ignore_for_file: file_names

import 'package:donorlink/Models/User.dart';
import 'package:donorlink/views/Donors/home_page.dart';
import 'package:donorlink/views/Register.dart';
import 'package:flutter/material.dart';


class Login extends StatefulWidget {
  const Login({super.key, required this.userType});
  
  final String userType;
  @override
  State<Login> createState() => _LoginState(userType: userType);

}

class _LoginState extends State<Login>{
  _LoginState({ required this.userType});

  final String userType;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  User? user;
  List<User> users = [];

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
              const Image(
                image: AssetImage('assets/images/Logo.png')
              ),
              const SizedBox(height: 20),
              //Code functionality to read inputs
              Form(key: _formKey,
              child: Column(children: [
                TextFormField(
                  decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Email'),
                  controller: emailController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Password'),
                  controller: passwordController,
                  obscureText: true,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                //Add this functionality
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Forgot Password'),
                  ),
                ),
                
                
                ElevatedButton(
                  onPressed: () {
                    //Add functionality to route to different modules based on userType
                    if (_formKey.currentState!.validate()) {
                      String email = emailController.text;
                      String password = passwordController.text;
                      for (User i in users){
                        if(i.authenticate(password, email)==true){
                          user = i;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage(user: user,)),
                          );
                        }
                      }
                      
                    }
                    
                  },
                  child: const Text('Sign In'),
                ),
              ]),),
              

              

              const SizedBox(height: 20),
              const Text('Don\'t Have an account?'),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Register(userType: userType,)),
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

}
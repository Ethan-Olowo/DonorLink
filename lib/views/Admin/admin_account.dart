import 'package:donorlink/Models/Admin.dart';
import 'package:donorlink/resources/appbar.dart';
import 'package:donorlink/views/Admin/edit_account.dart';
import 'package:donorlink/views/Admin/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminAccount extends StatelessWidget {
  final Admin user;
  const AdminAccount({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Bar(
          leading: IconButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(
                        user: user,
                      )));
        },
        icon: const Icon(Icons.home),
      )),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50),
              ),
              const SizedBox(height: 20),
              Text(user.toString()),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditAccount(
                                user: user,
                              )));
                },
                child: const Text('Edit'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                child: const Text('Log Out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

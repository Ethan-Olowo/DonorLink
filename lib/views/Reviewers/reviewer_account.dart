// reviewer_account.dart
import 'package:donorlink/Models/Reviewer.dart';
import 'package:donorlink/views/Reviewers/edit_account.dart';
import 'package:donorlink/views/Reviewers/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReviewerAccount extends StatefulWidget {
  final Reviewer reviewer;

  const ReviewerAccount({super.key, required this.reviewer});
@override
  _PageState createState() => _PageState();
}

class _PageState extends State<ReviewerAccount> {  

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviewer Account'),
        leading: widget.reviewer.approval == 'approved'? IconButton( onPressed: () { 
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(user: widget.reviewer,)));
         }, icon: const Icon(Icons.home),) :null,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center( child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
              
            ),
            const SizedBox(height: 20),
            Text(widget.reviewer.toString()),
            const SizedBox(height: 20),

            if (widget.reviewer.approval == 'requested') ElevatedButton(
              onPressed: () async {
                widget.reviewer.approval = 'pending';
                if(await widget.reviewer.updateUser()){
                  setState(() {
                    widget.reviewer.approval = 'pending';
                  });
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error updating user')));
                  widget.reviewer.approval = 'requested';
                }
              },
              child: const Text('Cancel Request'),
            ), 
            if (widget.reviewer.approval == 'pending') ElevatedButton(
              onPressed: () async {  
                widget.reviewer.approval = 'requested';
                if(await widget.reviewer.updateUser()){
                  setState(() {
                    widget.reviewer.approval = 'requested';
                  });
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error updating user')));
                  widget.reviewer.approval = 'pending';
                }
              },
              child: const Text('Request Approval'),
            ),
            if (widget.reviewer.approval == 'approved'|| widget.reviewer.approval == 'pending') ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditAccount(reviewer: widget.reviewer,)));
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
    ));
  }
}

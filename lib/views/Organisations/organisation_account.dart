
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/views/Organisations/edit_account.dart';
import 'package:donorlink/views/Organisations/home_page.dart';
import 'package:donorlink/views/Organisations/view_financials.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrgAccount extends StatefulWidget {
  final Organisation org;

  const OrgAccount({super.key, required this.org});
@override
  _PageState createState() => _PageState();
}

class _PageState extends State<OrgAccount> {  

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Organisation Account'),
        leading: widget.org.approval == 'approved'? IconButton( onPressed: () { 
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(user: widget.org,)));
         }, icon: const Icon(Icons.home),) 
         :IconButton(
          icon: const Icon(Icons.account_circle),
          onPressed: () {},
        ),
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
            Text(widget.org.toString()),
            Text('Approval: ${widget.org.approval}'),
            const SizedBox(height: 20),

            if (widget.org.approval == 'requested') ElevatedButton(
              onPressed: () async {
                widget.org.approval = 'pending';
                if(await widget.org.updateUser()){
                  setState(() {
                    widget.org.approval = 'pending';
                  });
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error updating user')));
                  widget.org.approval = 'requested';
                }
              },
              child: const Text('Cancel Request'),
            ), 
            if (widget.org.approval == 'pending') ElevatedButton(
              onPressed: () async {  
                widget.org.approval = 'requested';
                if(await widget.org.updateUser()){
                  setState(() {
                    widget.org.approval = 'requested';
                  });
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error updating user')));
                  widget.org.approval = 'pending';
                }
              },
              child: const Text('Request Approval'),
            ),
            if (widget.org.approval == 'approved'|| widget.org.approval == 'pending') ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditAccount(org: widget.org,)));
              },
              child: const Text('Edit'),
            ),
            if (widget.org.approval == 'requested')Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewFinancials(user: widget.org, requests: true, ),
                      ),
                    );
                  },
                  child: const Text('View Financial Document Requests'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewFinancials(user: widget.org, requests: false, ),
                      ),
                    );
                  },
                  child: const Text('View Submitted Financial Documents'),
                ),
              ],
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

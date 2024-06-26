import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/Models/Review.dart';
import 'package:donorlink/Models/Reviewer.dart';
import 'package:donorlink/views/Reviewers/review_confirmation.dart';
import 'package:flutter/material.dart';

class ReviewOrg extends StatefulWidget {
  final Reviewer user;
  final Organisation org;
  const ReviewOrg({super.key, required this.user, required this.org});

  @override
  _ReviewOrgState createState() => _ReviewOrgState();
}

class _ReviewOrgState extends State<ReviewOrg> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _commentController = TextEditingController();
  String? _approvalStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                items: const [
                  DropdownMenuItem(value: 'Approve', child: Text('Approve')),
                  DropdownMenuItem(value: 'Reject', child: Text('Reject')),
                ],
                onChanged: (value) {
                  setState(() {
                    _approvalStatus = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Approval',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an approval status';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _commentController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Comment',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a comment';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    bool app = _approvalStatus=='Approve';
                    Review? rev = await widget.user.reviewOrganisation(widget.org, app, _commentController.text);
                    if(rev != null){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewConfirmation(user: widget.user, rev: rev,))); 
                    }else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to Save Review')));
                    } 
                  }
                },
                child: const Text('Submit'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

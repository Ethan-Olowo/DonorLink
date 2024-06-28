import 'package:donorlink/Models/Reviewer.dart';
import 'package:donorlink/views/Reviewers/reviewer_account.dart';
import 'package:flutter/material.dart';

class EditAccount extends StatefulWidget {
  final Reviewer reviewer;

  const EditAccount({super.key, required this.reviewer});

  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  


  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.reviewer.name);
    _phoneController = TextEditingController(text: widget.reviewer.phone);
    _emailController = TextEditingController(text: widget.reviewer.email);
   
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _updateOrganisation() async {
    if (_formKey.currentState!.validate()) {
      widget.reviewer.name = _nameController.text;
      widget.reviewer.phone = _phoneController.text;
      //widget.org.email = _emailController.text;
      
      await widget.reviewer.updateUser()?
        Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReviewerAccount(reviewer: widget.reviewer),
              ),
            )
        :ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to Save Changes')));
        
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
              
              /*TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
              ),*/
              
              
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateOrganisation,
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

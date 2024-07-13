import 'package:donorlink/Models/Reviewer.dart';
import 'package:donorlink/views/Reviewers/reviewer_account.dart';
import 'package:donorlink/resources/input_validators.dart';
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
  


  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.reviewer.name);
    _phoneController = TextEditingController(text: widget.reviewer.phone);
   
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _updateReviewer() async {
    if (_formKey.currentState!.validate()) {
      widget.reviewer.name = _nameController.text;
      widget.reviewer.phone = _phoneController.text;
      
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
        toolbarHeight: 50,
        title: const Image(image: AssetImage('assets/images/NamedLogo.png'), height: 48,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text('Edit Account', style: Theme.of(context).textTheme.headlineSmall),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: nullValidator
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                validator: phoneValidator
              ),        
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateReviewer,
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

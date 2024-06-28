import 'package:donorlink/Models/Donor.dart';
import 'package:donorlink/views/Donors/donor_account.dart';
import 'package:flutter/material.dart';

class EditAccount extends StatefulWidget {
  final Donor user;

  const EditAccount({super.key, required this.user});

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
    _nameController = TextEditingController(text: widget.user.name);
    _phoneController = TextEditingController(text: widget.user.phone);
    _emailController = TextEditingController(text: widget.user.email);
   
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
      widget.user.name = _nameController.text;
      widget.user.phone = _phoneController.text;
      //widget.org.email = _emailController.text;
      
      await widget.user.updateUser()?
        Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DonorAccount(user: widget.user),
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
              Center(child: Text('Edit Account', style: Theme.of(context).textTheme.headlineSmall,)),
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

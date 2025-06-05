import 'package:donorlink/Models/Patient.dart';
import 'package:donorlink/resources/appbar.dart';
import 'package:donorlink/views/Patients/donor_account.dart';
import 'package:donorlink/resources/input_validators.dart';
import 'package:flutter/material.dart';

class EditAccount extends StatefulWidget {
  final Patient user;

  const EditAccount({super.key, required this.user});

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
    _nameController = TextEditingController(text: widget.user.name);
    _phoneController = TextEditingController(text: widget.user.phone);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _updateDonor() async {
    if (_formKey.currentState!.validate()) {
      widget.user.name = _nameController.text;
      widget.user.phone = _phoneController.text;

      await widget.user.updateUser()
          ? Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DonorAccount(user: widget.user),
              ),
            )
          : ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to Save Changes')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Bar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                  child: Text(
                'Edit Account',
                style: Theme.of(context).textTheme.headlineSmall,
              )),
              TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: nullValidator),
              TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Phone'),
                  validator: phoneValidator),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateDonor,
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

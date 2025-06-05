import 'package:donorlink/resources/appbar.dart';
import 'package:donorlink/views/Hospitals/organisation_account.dart';
import 'package:donorlink/resources/input_validators.dart';
import 'package:flutter/material.dart';
import 'package:donorlink/Models/Hospital.dart';

class EditAccount extends StatefulWidget {
  final Hospital org;

  const EditAccount({super.key, required this.org});

  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _locationController;


  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.org.name);
    _phoneController = TextEditingController(text: widget.org.phone);
    _locationController = TextEditingController(text: widget.org.location);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _updateOrganisation() async {
    if (_formKey.currentState!.validate()) {
      widget.org.name = _nameController.text;
      widget.org.phone = _phoneController.text;
      widget.org.location = _locationController.text;

      await widget.org.updateUser()
          ? Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrgAccount(org: widget.org),
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
              Text('Edit Organisation Account',
                  style: Theme.of(context).textTheme.headlineSmall),
              TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: nullValidator),
              TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(labelText: 'Phone'),
                  validator: phoneValidator),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
              ),
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

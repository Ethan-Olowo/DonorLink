import 'package:donorlink/views/Organisations/organisation_account.dart';
import 'package:flutter/material.dart';
import 'package:donorlink/Models/Organisation.dart';

class EditAccount extends StatefulWidget {
  final Organisation org;

  const EditAccount({super.key, required this.org});

  @override
  _EditAccountState createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _locationController;
  late TextEditingController _paymentDetailsController;

  final List<String> _charityTypes = [
    'Education',
    'Health',
    'Environment',
    'Animal Welfare',
    'Arts & Culture',
    'International Aid',
    'Community Development',
    'Research',
    'Relief Services'
  ];
  String? _selectedType;
  final List<String> _paymentMethods = ['Mpesa', 'Visa'];
  String? _selectedPaymentMethod;


  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.org.name);
    _phoneController = TextEditingController(text: widget.org.phone);
    _emailController = TextEditingController(text: widget.org.email);
    _locationController = TextEditingController(text: widget.org.location);
    _paymentDetailsController = TextEditingController(text: widget.org.paymentDetails);
    _selectedType = widget.org.type;
    _selectedPaymentMethod = widget.org.paymentMethod;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    _paymentDetailsController.dispose();
    super.dispose();
  }

  Future<void> _updateOrganisation() async {
    if (_formKey.currentState!.validate()) {
      widget.org.name = _nameController.text;
      widget.org.phone = _phoneController.text;
      //widget.org.email = _emailController.text;
      widget.org.type = _selectedType;
      widget.org.location = _locationController.text;
      widget.org.paymentMethod = _selectedPaymentMethod;
      widget.org.paymentDetails = _paymentDetailsController.text;

      // Update the organisation in the Firestore or any other state management solution you're using
      await widget.org.updateUser()?
        Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrgAccount(org: widget.org),
              ),
            )
        :ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to Save Changes')));
        
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Organisation Account'),
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
              
              DropdownButtonFormField<String>(
                value: _selectedType,
                decoration: const InputDecoration(labelText: 'Type'),
                items: _charityTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedType = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a type';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedPaymentMethod,
                decoration: const InputDecoration(labelText: 'Payment Method'),
                items: _paymentMethods.map((method) {
                  return DropdownMenuItem(
                    value: method,
                    child: Text(method),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMethod = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a payment method';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _paymentDetailsController,
                decoration: const InputDecoration(labelText: 'Payment Details'),
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

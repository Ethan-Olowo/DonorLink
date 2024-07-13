import 'package:donorlink/views/Organisations/organisation_account.dart';
import 'package:donorlink/resources/input_validators.dart';
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
    _locationController = TextEditingController(text: widget.org.location);
    _paymentDetailsController =
        TextEditingController(text: widget.org.paymentDetails);
    _selectedType = widget.org.type;
    _selectedPaymentMethod = widget.org.paymentMethod;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _paymentDetailsController.dispose();
    super.dispose();
  }

  Future<void> _updateOrganisation() async {
    if (_formKey.currentState!.validate()) {
      widget.org.name = _nameController.text;
      widget.org.phone = _phoneController.text;
      widget.org.type = _selectedType;
      widget.org.location = _locationController.text;
      widget.org.paymentMethod = _selectedPaymentMethod;
      widget.org.paymentDetails = _paymentDetailsController.text;

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
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Image(
          image: AssetImage('assets/images/NamedLogo.png'),
          height: 48,
        ),
      ),
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
                  validator: nullValidator),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                  value: _selectedPaymentMethod,
                  decoration:
                      const InputDecoration(labelText: 'Payment Method'),
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
                  validator: nullValidator),
              TextFormField(
                  controller: _paymentDetailsController,
                  decoration:
                      const InputDecoration(labelText: 'Payment Details'),
                  validator: nullValidator),
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

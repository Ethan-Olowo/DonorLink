import 'package:donorlink/Models/Appointment.dart';
import 'package:donorlink/Models/Donor.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/views/Donors/view_interaction.dart';
import 'package:flutter/material.dart';

class RequestAppointment extends StatefulWidget {
  final Organisation org;
  final Donor user;
  const RequestAppointment({super.key, required this.org, required this.user});

  @override
  RequestAppointmentState createState() => RequestAppointmentState();
}

class RequestAppointmentState extends State<RequestAppointment> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Image(image: AssetImage('assets/images/NamedLogo.png'), height: 48,),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text('Appointment with ${widget.org.name}', style: Theme.of(context).textTheme.headlineSmall),
                TextFormField(
                  controller: _reasonController,
                  decoration: const InputDecoration(labelText: 'Reason'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a reason';
                    }       
                    return null;
                  },
                ),
                TextFormField(
                  controller: _dateController,
                  decoration: const InputDecoration(
                    labelText: 'Appointment Date',
                    hintText: 'Select Date',
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null && picked != _selectedDate) {
                      setState(() {
                        _selectedDate = picked;
                        _dateController.text = "${picked.toLocal()}".split(' ')[0];

                      });
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an appointment date';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Appointment? app = await widget.user.requestAppointment(widget.org,_selectedDate!, _reasonController.text);
                      if(app != null){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => InteractionView(user: widget.user, element: app, New: true, type: 'Appointments',))); 
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Appointment request failed')));
                      }    
                    } else {
                      // Show error or warning
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill out all fields')),
                      );
                    }
                  },
                  child: const Text('Request'),
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
      ),
    );
  }
}

// rate.dart
import 'package:donorlink/Models/Donor.dart';
import 'package:donorlink/Models/Organisation.dart';
import 'package:donorlink/Models/Rating.dart';
import 'package:donorlink/views/Donors/rating_confirmation.dart';
import 'package:flutter/material.dart';

class Rate extends StatefulWidget {
  final Donor user;
  final Organisation org;
  const Rate({super.key, required this.org, required this.user});
   @override
  State<StatefulWidget> createState() => _RateState();
}
class _RateState extends State<Rate> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _ratingController= TextEditingController();
  final _commentController= TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _ratingController.dispose();
    _commentController.dispose();
    super.dispose();
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
        child: Column(
          children: [
            
            Text('Rate ${widget.org.name}', style: Theme.of(context).textTheme.headlineSmall,),
            Form(
              key: _formKey,
              child: Column(
              children: [TextFormField(
                controller: _ratingController,
                decoration: const InputDecoration(labelText: 'Rating out of 5'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a rating.'; 
                  }else if(double.parse(value) > 5){
                    return 'Please enter a number less than 5';
                  }
                  return null; 
                },
              ),
              TextFormField(
                controller: _commentController,
                decoration: const InputDecoration(labelText: 'Comment'),
              ),
              ]
            )
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  double score = double.parse(_ratingController.text);
                  String comment = _commentController.text;
                  Rating? rating = await widget.user.rateOrganisation(widget.org, score, comment);
                  if (rating != null) {
                  MaterialPageRoute(builder: (context) => RatingConfirmation(user: widget.user, rating: rating,),);
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Rating failed')));
                  }
              }},
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
  
 
}



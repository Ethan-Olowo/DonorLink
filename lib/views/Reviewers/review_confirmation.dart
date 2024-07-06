import 'package:donorlink/Models/Review.dart';
import 'package:donorlink/Models/Reviewer.dart';
import 'package:donorlink/views/Reviewers/home_page.dart';
import 'package:flutter/material.dart';

class ReviewConfirmation extends StatelessWidget {
  final Reviewer user;
  final Review rev;
  const ReviewConfirmation({super.key, required this.user, required this.rev});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Image(image: AssetImage('assets/images/NamedLogo.png'), height: 48,),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Review Confirmation', style: Theme.of(context).textTheme.headlineSmall),
            const Image(image: AssetImage('assets/images/NamedLogo.png'), height: 100,),
            const SizedBox(height: 20),
            Text(rev.toString()),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage(user: user,)));
              },
              child: const Text('Confirm'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:donorlink/views/Register.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Image(
          key: Key('appBarImage'), 
          image: AssetImage('assets/images/NamedLogo.png'),
          height: 48,
        ),
        leading: IconButton(
          key: const Key('backButton'), 
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Return to Landing Page',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Create a New Account',
              key: const Key('createAccountText'), 
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              'Select User Type',
              key: const Key('selectUserTypeText'), 
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              key: const Key('donorButton'), 
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Register(
                              userType: 'Donor',
                              key: Key('donorRegister'), 
                            )));
              },
              child: const Text('Donor'),
            ),
            ElevatedButton(
              key: const Key('organisationButton'), 
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Register(
                              userType: 'Organisation',
                              key: Key('organisationRegister'), 
                            )));
              },
              child: const Text('Organisation'),
            ),
            ElevatedButton(
              key: const Key('reviewerButton'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Register(
                              userType: 'Reviewer',
                              key: Key('reviewerRegister'), 
                            )));
              },
              child: const Text('Reviewer'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:donorlink/views/Register.dart';
import 'package:flutter/material.dart';


class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: const Image(image: AssetImage('assets/images/NamedLogo.png'), height: 48,),
        leading: IconButton(
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
            
            Text('Create a New Account', style: Theme.of(context).textTheme.displayLarge,),
            Text('Select User Type', style: Theme.of(context).textTheme.headlineSmall,),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Register(userType: 'Donor',)));
            }, child: const Text('Donor')),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Register(userType: 'Organisation',)));
            }, child: const Text('Organisation')),
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Register(userType: 'Reviewer',)));
            }, child: const Text('Reviewer')),
          ],
        ),
      ),
    );
  }
}

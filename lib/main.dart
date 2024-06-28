import 'package:donorlink/firebase_options.dart';
import 'package:donorlink/theme.dart';
import 'package:donorlink/views/Login.dart';
import 'package:donorlink/views/Splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
 );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DonorLink',
      
      theme: AppTheme.themeData, 
      
      home:  const MyAppHome(),
      );
  }
}
      
class MyAppHome extends StatelessWidget {
  const MyAppHome({super.key});


        @override
        Widget build(BuildContext context) {
          return Scaffold(
            
            body: Center(
              child: Column(
                
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Welcome to',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const Image(image: AssetImage('assets/images/NamedLogo.png'), height: 200,),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
                    },
                    child: const Text('Login'),
                  ),
                  
                  const SizedBox(height: 10,),
                  
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Splashscreen()));
                    },
                    child: const Text('Create User'),
                  ),
                ],
              ),
            ),
          );
        }

}



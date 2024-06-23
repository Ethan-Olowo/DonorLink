import 'package:donorlink/firebase_options.dart';
import 'package:donorlink/views/Splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

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
      
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue,
        brightness: Brightness.light, background: HexColor('eff0f4')),
        useMaterial3: true,
      ),

      
      //Add Text Theme 

      home:  const MyAppHome(),
      );
  }
}
      
class MyAppHome extends StatelessWidget {
  const MyAppHome({super.key});


        @override
        Widget build(BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('DonorLink'),
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              
            ),
            body: Center(
              child: Column(
                
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Welcome to',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const Image(image: AssetImage('assets/images/Logo.png')),
                  
                  SizedBox( 
                    width: 100,
                    child: FloatingActionButton(
                      onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Splashscreen()));
                      },
                    tooltip: 'Go To Select User',
                    child: const Text('Proceed'),
                  ),
                  ), // This trailing comma makes auto-formatting nicer for build methods.
                ],
              ),
            ),
          );
        }

}



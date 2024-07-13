import 'package:donorlink/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:donorlink/views/Login.dart';

void main() {
  group('authenticate', () {
    
    test('returns user UID on successful login', () async {
      //Initialize firebase
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      // Call authenticate function
      final result = await authenticate('ethan.olowo@icloud.com', '123456');

      // Verify result
      expect(result, 'gYaUacYbwPSS7oUvIC68x0ecOxj2');
    });
  });
}

import 'package:firebase_core/firebase_core.dart';
import 'package:cipher_schools_flutter_assignment/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyD6rG39chUIEtn6nvLLTVwmkgbAm5GiyGA',
        appId: '1:474560862747:android:d2895924fdc1967839b6be',
        messagingSenderId: '474560862747',
        projectId: 'sample-b8d58',
        storageBucket: 'sample-b8d58.appspot.com',
      )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

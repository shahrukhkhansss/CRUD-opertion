import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDx8FzpppS3h18ApjVmxezxZt0VkM1xf-Y",
          authDomain: "cruddatabase-347bb.firebaseapp.com",
          projectId: "cruddatabase-347bb",
          storageBucket: "cruddatabase-347bb.appspot.com",
          messagingSenderId: "147070649227",
          appId: "1:147070649227:web:64f905274a43d48d6f658e",
          measurementId: "G-HF69PDG4L2"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'crud',
      theme: ThemeData(),
      home: const MyHomePage(),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notefirestore/src/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
// Replace with actual values
    options: const FirebaseOptions(
      apiKey: "AIzaSyDVFiuug21vW6pKXWS2KfN_cJG3aHmhpiE",
      appId: "1:673025131979:android:67c766ae172fd52750e24e",
      messagingSenderId: "673025131979",
      projectId: "note-firestore-2566b",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Note',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Firestore Note'),
    );
  }
}

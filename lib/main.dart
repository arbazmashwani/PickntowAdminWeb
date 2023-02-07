import 'package:adminweb/helpers/constants.dart';
import 'package:adminweb/screens/dashboard.dart';
import 'package:adminweb/screens/login/main.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'helpers/firebase_options.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> initialize =
        Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            focusColor: Color(0xff343A40),
            inputDecorationTheme: const InputDecorationTheme(
              floatingLabelStyle: TextStyle(
                color: Color(0xff343A40),
              ),
            ),
            primarySwatch: Colors.blue,
            primaryColor: kPrimaryColor),
        home: FutureBuilder(
            future: initialize,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.connectionState == ConnectionState.done) {
                  return DashboardScreen(name: "name", uid: "");
                }
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mysrc_connect/how_to_login.dart';
import 'package:provider/provider.dart';

import 'update_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UpdateModel()),
        ChangeNotifierProvider(create: (_) => TuitionEnrollmentCountModel()),
        ChangeNotifierProvider(create: (_) => TuitionEnrollmentModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HowToLogin(),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pingolearn/app/app.dart';
import 'package:pingolearn/app/app_bootstratper.dart';
import 'package:pingolearn/screens/authentication/auth_provider.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffF5F9FD),
      ),
      home: const App(),
    );
  }
}

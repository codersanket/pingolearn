import 'package:flutter/material.dart';

import 'package:pingolearn/app/app_bootstratper.dart';
import 'package:pingolearn/screens/authentication/auth_screen.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    AppBootStrapper.instance.initialize();

    AppBootStrapper.instance.isInitialized.listen((value) {
      if (value) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const AuthWrapper()));
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

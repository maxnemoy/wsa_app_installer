import 'package:flutter/material.dart';
import 'package:wsa_app_installer/main_screen.dart';

void main() async {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "WSA App Installer",
      theme: ThemeData.dark(), home: const MainPage());
  }
}

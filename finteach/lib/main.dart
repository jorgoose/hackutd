import 'package:flutter/material.dart';
import 'package:finteach/Presentation/app.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures that you have bindings initialized before runApp
  await dotenv.load(fileName: ".env"); // Make sure to call load on dotenv

  runApp(MyApp()); // Replace with your actual app widget
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

      ),
      home: ModuleList(),
    );
  }
}

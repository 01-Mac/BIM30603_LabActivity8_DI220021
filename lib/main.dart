import 'package:flutter/material.dart';
import 'package:labactivity8/pages/handyman_ add _page.dart';
import 'package:labactivity8/auth/login_or_register.dart';
import 'package:labactivity8/pages/handyman_list_page.dart';
import 'package:labactivity8/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginOrRegister(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}

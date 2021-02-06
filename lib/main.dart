import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:marketapp/provider/cart_provider.dart';
import 'package:marketapp/screens/login_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Market App',
        theme: ThemeData(
          primaryColor: Colors.teal[200],
          // accentColor: Colors.white,
        ),
        home: LoginPage(),
      ),
    );
  }
}

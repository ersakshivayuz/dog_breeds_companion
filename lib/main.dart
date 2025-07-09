import 'package:dog_breeds/presentations/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

void main() {
 runApp(MyApp());

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
     title: 'Dog Breeds Companion',
     theme: ThemeData(
         primarySwatch: Colors.blue,
      primaryColor: Colors.blue,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,

     ),
     home: DashboardScreen(),
    );
  }
}

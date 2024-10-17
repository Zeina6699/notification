// lib/main.dart

import 'package:flutter/material.dart';
import 'package:notification/screen/first_page.dart';


void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connectivity Notification App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PageOne()
    );
  }
}



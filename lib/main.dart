import 'package:aloqa_nazorati/screens/appeals/pages/appeal_response_page.dart';
import 'package:aloqa_nazorati/screens/appeals/pages/create_appeal_page.dart';
import 'package:aloqa_nazorati/screens/auth/pages/id_page.dart';
import 'package:aloqa_nazorati/screens/auth/pages/welcome_page.dart';
import 'package:aloqa_nazorati/screens/main/main_page.dart';
import 'package:aloqa_nazorati/screens/profile/usage_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const IdGovPage(),
    );
  }
}

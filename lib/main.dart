import 'package:aloqa_nazorati/screens/auth/pages/id_page.dart';
import 'package:aloqa_nazorati/utils/di/locator.dart';
import 'package:flutter/material.dart';

// List<CameraDescription>? cameraList;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  // cameraList = await availableCameras();
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

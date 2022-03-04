import 'package:flutter/material.dart';
import 'package:pinterest_clone_project/pages/home_page.dart';
import 'package:pinterest_clone_project/pages/profel_page.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

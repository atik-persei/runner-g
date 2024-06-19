import 'package:flutter/material.dart';
import 'package:runner_g/navigation/routes.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Screen'),
      ),
      body: Column(
        children: [
          const Text('Home'),
          TextButton(onPressed: () {
            Navigator.pushNamed(context, Routes.loginPath);
          }, child: const Text('123'))
        ],
      ),
    );
  }
}
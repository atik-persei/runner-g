// Design Library
import 'package:flutter/material.dart';

// Screen Library

class GroupScreen extends StatefulWidget {
  const GroupScreen({super.key});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RunnerG'),
      ),
      body: const Column(
        children: [
          Text('Home'),
        ],
      ),
    );
  }
}

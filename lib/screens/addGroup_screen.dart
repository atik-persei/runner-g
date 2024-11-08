// Design Library
import 'package:flutter/material.dart';

// Screen Library

class AddGroupScreen extends StatefulWidget {
  const AddGroupScreen({super.key});

  @override
  State<AddGroupScreen> createState() => _AddGroupScreenState();
}

class _AddGroupScreenState extends State<AddGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RunnerG'),
      ),
      body: const Column(
        children: [
          Text('add group'),
        ],
      ),
    );
  }
}

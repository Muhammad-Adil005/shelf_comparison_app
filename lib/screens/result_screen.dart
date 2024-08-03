// result_screen.dart
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final String comparisonResult;

  const ResultScreen({super.key, required this.comparisonResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Comparison Results'),
      ),
      body: Center(
        child: Text(comparisonResult),
      ),
    );
  }
}

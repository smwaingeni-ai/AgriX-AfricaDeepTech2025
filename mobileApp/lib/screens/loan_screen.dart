import 'package:flutter/material.dart';

class LoanScreen extends StatelessWidget {
  const LoanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply for a Loan'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Loan Application Screen (Coming Soon)',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

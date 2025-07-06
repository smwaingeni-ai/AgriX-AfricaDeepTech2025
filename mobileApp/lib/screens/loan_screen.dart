import 'package:flutter/material.dart';

class LoanScreen extends StatelessWidget {
  const LoanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Apply for a Loan'),
      ),
      body: Center(
        child: Text(
          'Loan Application Screen (Coming Soon)',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}

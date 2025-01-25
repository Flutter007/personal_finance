import 'package:cw26/screens/transactions_screen.dart';
import 'package:flutter/material.dart';

class Cw26 extends StatefulWidget {
  const Cw26({super.key});

  @override
  State<Cw26> createState() => _Cw26State();
}

class _Cw26State extends State<Cw26> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: TransactionsScreen(),
    );
  }
}

import 'package:cw26/models/transactions.dart';
import 'package:cw26/screens/transactions_screen.dart';
import 'package:flutter/material.dart';

class Cw26 extends StatefulWidget {
  const Cw26({super.key});

  @override
  State<Cw26> createState() => _Cw26State();
}

class _Cw26State extends State<Cw26> {
  List<Transaction> transactions = [
    Transaction(title: 'Coffe', amount: 150),
    Transaction(title: 'Cinema', amount: 500),
    Transaction(title: 'Bus fare', amount: 20),
    Transaction(title: 'Water bill', amount: 300),
    Transaction(title: 'Flowers', amount: 500),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: TransactionsScreen(
        transactions: transactions,
      ),
    );
  }
}

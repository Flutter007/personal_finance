import 'package:cw26/models/transactions.dart';
import 'package:cw26/screens/transactions_screen.dart';
import 'package:cw26/widget/add_transaction.dart';
import 'package:flutter/material.dart';

class Cw26 extends StatefulWidget {
  const Cw26({super.key});

  @override
  State<Cw26> createState() => _Cw26State();
}

class _Cw26State extends State<Cw26> {
  List<Transaction> transactions = [
    Transaction(title: 'Coffee', amount: 150, dateTime: DateTime.now()),
    Transaction(title: 'Cinema', amount: 500, dateTime: DateTime.now()),
    Transaction(title: 'Bus fare', amount: 20, dateTime: DateTime.now()),
    Transaction(title: 'Water bill', amount: 300, dateTime: DateTime.now()),
    Transaction(title: 'Flowers', amount: 500, dateTime: DateTime.now()),
  ];

  void addTrans(Transaction addTransactions) {
    setState(() {
      transactions.add(addTransactions);
    });
  }

  void openAddTransactionSheet() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => AddTransaction(
        onTransactionCreated: addTrans,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
        actions: [
          IconButton(onPressed: openAddTransactionSheet, icon: Icon(Icons.add))
        ],
      ),
      body: TransactionsScreen(
        transactions: transactions,
      ),
    );
  }
}

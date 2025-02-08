import 'package:cw26/models/transactions.dart';
import 'package:cw26/screens/transactions_screen.dart';
import 'package:cw26/widget/transaction_form.dart';
import 'package:flutter/material.dart';

class Cw26 extends StatefulWidget {
  const Cw26({super.key});

  @override
  State<Cw26> createState() => _Cw26State();
}

class _Cw26State extends State<Cw26> {
  List<Transaction> transactions = [
    Transaction(
      title: 'Coffee',
      amount: 150,
      dateTime: DateTime.now(),
      categoryId: 'food_and_drinks',
    ),
    Transaction(
      title: 'Cinema',
      amount: 500,
      dateTime: DateTime.now(),
      categoryId: 'entertainment',
    ),
    Transaction(
      title: 'Bus fare',
      amount: 20,
      dateTime: DateTime.now(),
      categoryId: 'transport',
    ),
    Transaction(
      title: 'Water bill',
      amount: 300,
      dateTime: DateTime.now(),
      categoryId: 'home',
    ),
    Transaction(
      title: 'Groceries',
      amount: 500,
      dateTime: DateTime.now(),
      categoryId: 'home',
    ),
  ];

  void addTrans(Transaction addTransactions) {
    setState(() {
      transactions.add(addTransactions);
    });
  }

  void deleteTrans(String id) {
    setState(() {
      transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  void editTrans(Transaction editTransaction) {
    setState(() {
      final index = transactions
          .indexWhere((transaction) => transaction.id == editTransaction.id);
      transactions[index] = editTransaction;
    });
  }

  void openAddTransactionSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (ctx) => TransactionForm(
        onTransactionCreated: addTrans,
      ),
    );
  }

  void openEditTransSheet(String id) {
    final existingTransaction =
        transactions.firstWhere((transaction) => transaction.id == id);
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (ctx) => TransactionForm(
        onTransactionCreated: editTrans,
        existingTransaction: existingTransaction,
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
        onTransactionDeleted: deleteTrans,
        onTransactionEdited: openEditTransSheet,
      ),
    );
  }
}

import 'package:cw26/models/transactions.dart';
import 'package:cw26/widget/transaction_card.dart';
import 'package:flutter/material.dart';

class TransactionsScreen extends StatelessWidget {
  final List<Transaction> transactions;
  const TransactionsScreen({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: transactions
            .map((transaction) => TransactionCard(transaction: transaction))
            .toList(),
      ),
    );
  }
}

import 'package:cw26/models/transactions.dart';
import 'package:cw26/widget/transaction_card.dart';
import 'package:flutter/material.dart';

class TransactionsScreen extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String id) onTransactionDeleted;
  final void Function(String id) onTransactionEdited;
  const TransactionsScreen(
      {super.key,
      required this.transactions,
      required this.onTransactionDeleted,
      required this.onTransactionEdited});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: transactions
            .map(
              (transaction) => Dismissible(
                key: ValueKey(transaction.id),
                onDismissed: (direction) =>
                    onTransactionDeleted(transaction.id),
                child: InkWell(
                  onTap: () => onTransactionEdited(transaction.id),
                  child: TransactionCard(transaction: transaction),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

import 'package:cw26/helpers/format_datetime.dart';
import 'package:cw26/models/transactions.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bodyLargeStyle = theme.textTheme.bodyLarge!;
    final titleSmallStyle = theme.textTheme.titleSmall!;
    final category = transaction.category;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  transaction.title,
                  style: bodyLargeStyle,
                ),
                Text(
                  transaction.formattedAmount,
                  style: bodyLargeStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.error,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      category.icon,
                      size: 16,
                      color: theme.colorScheme.tertiary,
                    ),
                    SizedBox(width: 4),
                    Text(category.title, style: titleSmallStyle)
                  ],
                ),
                Text(
                  formatDateTime(transaction.dateTime),
                  style: titleSmallStyle.copyWith(
                    color: theme.colorScheme.tertiary,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

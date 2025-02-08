import 'package:cw26/data/categories_data.dart';
import 'package:cw26/models/transaction_category.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime dateTime;
  final String categoryId;

  Transaction({
    String? id,
    required this.title,
    required this.amount,
    required this.dateTime,
    required this.categoryId,
  }) : id = id ?? uuid.v4();

  String get formattedAmount {
    return '-${amount.toStringAsFixed(2)}KGS';
  }

  TransactionCategory get category {
    return categories.firstWhere((category) => category.id == categoryId);
  }
}

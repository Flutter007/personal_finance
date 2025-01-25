class Transaction {
  final String title;
  final double amount;

  Transaction({required this.title, required this.amount});
  String get formattedAmount {
    return '-${amount.toStringAsFixed(2)}KGS';
  }
}

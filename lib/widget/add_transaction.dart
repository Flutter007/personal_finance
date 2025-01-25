import 'package:cw26/models/transactions.dart';
import 'package:flutter/material.dart';

class AddTransaction extends StatefulWidget {
  final void Function(Transaction newTransaction) onTransactionCreated;
  const AddTransaction({super.key, required this.onTransactionCreated});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  var title = '';
  var amount = '';

  void onCanceled() {
    Navigator.pop(context);
  }

  void onSave() {
    final addTransaction =
        Transaction(title: title, amount: double.parse(amount));
    widget.onTransactionCreated(addTransaction);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                  child: TextField(
                onChanged: (value) => setState(() {
                  title = value;
                }),
                decoration: InputDecoration(
                  label: Text('Title'),
                ),
              )),
              SizedBox(
                width: 16,
              ),
              Expanded(
                  child: TextField(
                onChanged: (value) => setState(() {
                  amount = value;
                }),
                decoration: InputDecoration(
                  label: Text('Amount'),
                ),
              )),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: onCanceled,
                  child: Text('Cancel'),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: onSave,
                  child: Text('Save'),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

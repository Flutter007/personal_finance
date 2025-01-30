import 'package:cw26/helpers/format_datetime.dart';
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
  var selectedDate = DateTime.now();
  var selectedTimeOfDay = TimeOfDay.now();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dateController.text = formatDate(selectedDate);
    timeController.text = formatTime(selectedTimeOfDay);
  }

  void onCanceled() {
    Navigator.pop(context);
  }

  void onSave() {
    final dateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTimeOfDay.hour,
      selectedTimeOfDay.minute,
    );
    final addTransaction = Transaction(
      title: title,
      amount: double.parse(amount),
      dateTime: dateTime,
    );
    widget.onTransactionCreated(addTransaction);
    Navigator.pop(context);
  }

  void onDateTap() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year + 1, now.month, now.day);

    final dateFromUser = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDate: selectedDate,
    );
    if (dateFromUser != null) {
      setState(() {
        selectedDate = dateFromUser;
        dateController.text = formatDate(dateFromUser);
      });
    }
  }

  void onTimeTap() async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: selectedTimeOfDay,
    );
    if (selectedTime != null) {
      setState(() {
        selectedTimeOfDay = selectedTime;
        timeController.text = formatTime(selectedTime);
      });
    }
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
                  onTap: onDateTap,
                  readOnly: true,
                  controller: dateController,
                  decoration: InputDecoration(label: Text('Date')),
                ),
              ),
              SizedBox(width: 15),
              SizedBox(
                width: 100,
                child: TextField(
                  onTap: onTimeTap,
                  controller: timeController,
                  readOnly: true,
                  decoration: InputDecoration(
                    label: Text('Time'),
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 16),
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
          SizedBox(height: 16),
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

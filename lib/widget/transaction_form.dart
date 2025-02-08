import 'package:cw26/data/categories_data.dart';
import 'package:cw26/helpers/format_datetime.dart';
import 'package:cw26/models/transactions.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(Transaction newTransaction) onTransactionCreated;
  final Transaction? existingTransaction;
  const TransactionForm(
      {super.key,
      required this.onTransactionCreated,
      this.existingTransaction});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  var selectedDate = DateTime.now();
  var selectedTimeOfDay = TimeOfDay.now();
  String? selectedCategory;

  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.existingTransaction != null) {
      final existingTransaction = widget.existingTransaction!;
      titleController.text = existingTransaction.title;
      amountController.text = existingTransaction.amount.toString();
      selectedDate = existingTransaction.dateTime;
      selectedTimeOfDay = TimeOfDay.fromDateTime(selectedDate);
      selectedCategory = existingTransaction.categoryId;
    }
    dateController.text = formatDate(selectedDate);
    timeController.text = formatTime(selectedTimeOfDay);
  }

  @override
  void dispose() {
    dateController.dispose();
    timeController.dispose();
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void onCanceled() {
    Navigator.pop(context);
  }

  bool isTransactionInvalid() {
    final parsedAmount = double.tryParse(amountController.text);
    final amountIsValid = parsedAmount == null || parsedAmount <= 0;
    return titleController.text.trim().isEmpty ||
        amountIsValid ||
        selectedCategory == null;
  }

  void onSave() {
    if (isTransactionInvalid()) {
      return;
    }
    final dateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTimeOfDay.hour,
      selectedTimeOfDay.minute,
    );
    final addTransaction = Transaction(
      id: widget.existingTransaction?.id,
      title: titleController.text.trim(),
      amount: double.parse(amountController.text),
      dateTime: dateTime,
      categoryId: selectedCategory!,
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
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + bottomInset),
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
                  controller: titleController,
                  decoration: InputDecoration(
                    label: Text('Title'),
                  ),
                )),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    label: Text('Amount'),
                  ),
                )),
              ],
            ),
            SizedBox(height: 16),
            DropdownMenu(
              expandedInsets: EdgeInsets.zero,
              label: Text(
                "Category : ",
              ),
              inputDecorationTheme: theme.inputDecorationTheme,
              initialSelection: selectedCategory,
              onSelected: (value) => setState(
                () => selectedCategory = value,
              ),
              dropdownMenuEntries: categories
                  .map(
                    (category) => DropdownMenuEntry(
                      value: category.id,
                      leadingIcon: Icon(category.icon),
                      label: category.title,
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 14),
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
                    onPressed: isTransactionInvalid() ? null : onSave,
                    child: Text('Save'),
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

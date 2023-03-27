import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTransaction;

  const NewTransaction({super.key, required this.newTransaction});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  submitDate(context) {
    final enteredTitle = titleController.text;
    final entetedAmount = double.parse(amountController.text);
    if (enteredTitle.isNotEmpty || entetedAmount >= 0 || selectedDate != null) {
      widget.newTransaction(enteredTitle, entetedAmount, selectedDate);
      Navigator.of(context).pop();
    }
  }

  DateTime? selectedDate;

  datePicker(context) {
    return showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      } else {
        selectedDate = value;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(label: Text('title')),
              controller: titleController,
              onSubmitted: (_) {
                submitDate(context);
              },
            ),
            TextField(
              decoration: const InputDecoration(label: Text('amount')),
              controller: amountController,
              onSubmitted: (_) {
                submitDate(context);
              },
            ),
            SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    (selectedDate == null)
                        ? "No Date Choosen"
                        : DateFormat.yMd().format(selectedDate!),
                  ),
                  TextButton(
                      onPressed: () => datePicker(context),
                      child: const Text("Select Date"))
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () => submitDate(context),
                child: const Text("Add Transaction"))
          ],
        ),
      ),
    );
  }
}

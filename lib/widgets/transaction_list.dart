import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> userTransactions;
  const TransactionList({super.key, required this.userTransactions});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    if (widget.userTransactions.isEmpty) {
      return const Center(child: Text("There is no Transaction Yet!"));
    } else {
      return ListView.builder(
          itemCount: widget.userTransactions.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Card(
                elevation: 6,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(5),
                  leading: CircleAvatar(
                    radius: 40,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: FittedBox(
                        child: Text(
                          '\$${widget.userTransactions[index].amount}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    widget.userTransactions[index].title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd()
                        .format(widget.userTransactions[index].date),
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      widget.userTransactions.removeAt(index);
                      setState(() {});
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            );
          });
    }
  }
}

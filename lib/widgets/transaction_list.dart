import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return transactions.isEmpty
          ? Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 0.60,
                  child: Image.asset(
                    'assets/images/empty_state.jpg',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    leading: Container(
                        width: 90,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[400],
                              offset: const Offset(
                                0.0,
                                3.0,
                              ),
                              blurRadius: 3.0,
                              spreadRadius: 2.0,
                            )
                          ],
                        ),
                        child: Padding(
                            padding: EdgeInsets.all(8),
                            child: FittedBox(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${transactions[index].amount.toStringAsFixed(0)}',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    ' CZK',
                                    style: TextStyle(
                                        fontSize: 8, color: Colors.white),
                                  )
                                ],
                              ),
                            ))),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () => deleteTx(transactions[index].id),
                    ),
                  ),
                );
              },
              itemCount: transactions.length);
    });
  }
}

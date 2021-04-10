import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: transactions.isEmpty
            ? Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Text(
                      'No transactions added yet!',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Container(
                    height: 200,
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
                              borderRadius: BorderRadius.circular(10)),
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
                    ),
                  );
                },
                itemCount: transactions.length));
  }
}

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  Widget build(BuildContext context) {
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
                        '${transaction.amount.toStringAsFixed(0)}',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        ' CZK',
                        style: TextStyle(fontSize: 8, color: Colors.white),
                      )
                    ],
                  ),
                ))),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        subtitle: Text(DateFormat.yMMMd().format(transaction.date)),
        trailing: MediaQuery.of(context).size.width > 460
            ? TextButton.icon(
                onPressed: () => deleteTx(transaction.id),
                icon: Icon(Icons.delete),
                label: const Text('delete'),
                style:
                    TextButton.styleFrom(primary: Theme.of(context).errorColor))
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => deleteTx(transaction.id),
              ),
      ),
    );
  }
}

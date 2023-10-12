import 'Expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCard extends StatelessWidget {
//property
  final Expense ex;
//constructor
  CustomCard(this.ex);
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(10),
        elevation: 15,
        child: Row(
          children: [
// 1st child of the row is the amount
            Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  ex.amount.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
// 2nd child of the row is a column containing children itself.
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
// col child 1 is title
                Text(ex.title,
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//col child 2 is the date
                Text(DateFormat('dd-MM-yyyy').format(ex.date))
              ],
            ),
          ],
        ));
  }
}

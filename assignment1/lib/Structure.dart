import 'package:assignment1/myCategory.dart';

import 'Expense.dart';
import 'NewExWidget.dart';
import 'ExListWidget.dart';
import 'package:flutter/material.dart';

class Structure extends StatefulWidget {
  State<StatefulWidget> createState() {
    return StructureState();
  }
}

void f() {}

class StructureState extends State<Structure> {
  final List<Expense> expenseList = [];

  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          NewExWidget(callBackFunc: addNewExpense),
          ExListWidget(expenseList, f)
        ],
      ),
    );
  }

  void addNewExpense(
      {required String t, required double a, required MyCategory c}) {
    setState(() {
      Expense e = Expense(
          title: t,
          amount: a,
          date: DateTime.now(),
          id: DateTime.now().toString(),
          category: c);
      expenseList.add(e);
    });
  }
}

import 'package:flutter/cupertino.dart';

import 'Expense.dart';
import 'myCategory.dart';
import 'package:flutter/material.dart';
import 'NewExWidget.dart';
import 'ExListWidget.dart';
import 'dart:io' show Platform;

void main() {
  runApp(MyApp());
}

//root widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Masroufi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

// home widget
class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Expense> expenseList = [];
  double sum = 0;
  double monthSum = 0;
  void addNewExpense(
      {required String t,
      required double a,
      required DateTime d,
      required MyCategory c}) {
    if (c == MyCategory.none) return;
    setState(() {
      Expense e = Expense(
          title: t,
          amount: a,
          date: d,
          id: DateTime.now().toString(),
          category: c);
      expenseList.add(e);
      sum += e.amount;
      updateLastMonthSum();
      Navigator.of(context).pop();
    });
  }

  void updateLastMonthSum() {
    double res = 0;
    for (Expense e in expenseList) {
      if (e.date.year == DateTime.now().year &&
          e.date.month == DateTime.now().month) res += e.amount;
    }
    monthSum = res;
  }

  void deleteExpense(String idToDelete) {
    setState(() {
      sum -=
          expenseList.firstWhere((element) => element.id == idToDelete).amount;
      expenseList.removeWhere((element) {
        return element.id == idToDelete;
      });
      updateLastMonthSum();
    });
  }

  void showNewExpenseBottomSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (sheetContext) {
          return NewExWidget(callBackFunc: addNewExpense);
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text("Masroufi"), actions: [
        Platform.isAndroid
            ? MaterialButton(
                onPressed: () {
                  showNewExpenseBottomSheet(context);
                },
                child: const Icon(Icons.add))
            : Container(
                margin: EdgeInsets.all(10),
                child: CupertinoButton(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    color: Colors.white,
                    padding: EdgeInsets.all(2),
                    child: const Icon(
                      Icons.add,
                      color: Colors.lightBlue,
                    ),
                    onPressed: () {
                      showNewExpenseBottomSheet(context);
                    }),
              )
      ]),
      body: size.width < 600
          ? SingleChildScrollView(
              child: Column(
              children: [
// total
                Container(
                  width: double.infinity,
                  height: 200,
                  margin: const EdgeInsets.all(10),
                  child: Card(
                    elevation: 5,
                    child: Center(
                        child: Text(
                            "Total Expenses: $sum\nExpenses this month: ${monthSum.toStringAsFixed(2)}")),
                  ),
                ),
// structure
                ExListWidget(expenseList, deleteExpense),
              ],
            ))
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height - 100,
                      width: size.width / 3,
                      // margin: EdgeInsets.fromLTRB(30, 15, 0, 0),
                      child: Card(
                        elevation: 5,
                        child: Center(child: Text(sum.toString())),
                      ),
                    )
                  ],
                ),
                Container(
                    height: double.infinity,
                    width: size.width / 2 + 10,
                    child: SingleChildScrollView(
                        child: Column(children: [
                      ExListWidget(expenseList, deleteExpense)
                    ])))
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showNewExpenseBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

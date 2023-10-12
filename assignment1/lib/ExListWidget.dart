import 'dart:io';

import 'package:assignment1/myCategory.dart';
import 'package:flutter/cupertino.dart';

import 'Expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ExListWidget extends StatelessWidget {
  List<Expense> l_ex = [];
  Function deleteCallback = () {};
  ExListWidget(List<Expense> l, Function f) {
    this.l_ex = l;
    this.deleteCallback = f;
  }

  IconData getIconbyCategory(MyCategory c) {
    if (c == MyCategory.car) return Icons.car_repair;
    if (c == MyCategory.food) return Icons.fastfood;
    if (c == MyCategory.clothes) return Icons.accessibility;
    return Icons.home;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400, // necessary
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 2.0,
              ),
            ),
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.lightBlue,
                ),
                child: Text(
                  "${l_ex[index].amount.ceil()}\nEGP",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              title: Center(
                  child: Text(
                l_ex[index].title,
                style: const TextStyle(fontSize: 24),
              )),
              subtitle: Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: const Icon(
                        Icons.calendar_month,
                        size: 25,
                      ),
                    ),
                    Text(
                      DateFormat('yyyy-MM-dd').format(l_ex[index].date),
                      style: const TextStyle(
                          fontSize: 18,
                          backgroundColor: Color.fromRGBO(30, 30, 200, 0)),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Icon(getIconbyCategory(l_ex[index].category),
                          size: 25),
                    )
                  ],
                ),
              ),
              trailing: Platform.isIOS
                  ? CupertinoButton(
                      child:
                          const Icon(Icons.delete, color: Colors.red, size: 40),
                      onPressed: () {
                        deleteCallback(l_ex[index].id);
                      })
                  : IconButton(
                      onPressed: () {
                        deleteCallback(l_ex[index].id);
                      },
                      icon:
                          const Icon(Icons.delete, color: Colors.red, size: 40),
                    ),
            ),
          );
        },
        itemCount: l_ex.length,
      ),
    );
  }
}

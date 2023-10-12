import 'package:assignment1/myCategory.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExWidget extends StatefulWidget {
  final Function callBackFunc;
  NewExWidget({required this.callBackFunc});

  @override
  State<NewExWidget> createState() => _NewExWidgetState();
}

class _NewExWidgetState extends State<NewExWidget> {
  final titleValue = TextEditingController();

  final amountValue = TextEditingController();
  DateTime selectedDate = DateTime.utc(1970, 1, 1);
  void openDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019, 1, 1),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      } // if user presses cancel
// else if he/she presses OK
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  MyCategory selectedIcon = MyCategory.none;

  void handleSelect(MyCategory idx) {
    setState(() {
      if (selectedIcon == idx)
        selectedIcon = MyCategory.none;
      else
        selectedIcon = idx;
    });
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 50),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () => {handleSelect(MyCategory.car)},
                  child: Icon(Icons.car_repair,
                      size: 50,
                      color: selectedIcon == MyCategory.car
                          ? Colors.black
                          : Colors.grey),
                ),
                InkWell(
                  onTap: () => {handleSelect(MyCategory.food)},
                  child: Icon(Icons.fastfood,
                      size: 50,
                      color: selectedIcon == MyCategory.food
                          ? Colors.black
                          : Colors.grey),
                ),
                InkWell(
                  onTap: () => {handleSelect(MyCategory.clothes)},
                  child: Icon(Icons.accessibility,
                      size: 50,
                      color: selectedIcon == MyCategory.clothes
                          ? Colors.black
                          : Colors.grey),
                )
              ],
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Expense title'),
              controller: titleValue,
            ),
            TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Amount in EGP'),
                controller: amountValue),
            Row(
              children: [
                Expanded(
                    child: Text(selectedDate == DateTime.utc(1970, 1, 1)
                        ? 'No Date chosen'
                        : DateFormat.yMd().format(selectedDate))),
                TextButton(
                    onPressed: () {
                      openDatePicker();
                    },
                    child: Text('Choose date')),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                widget.callBackFunc(
                    t: titleValue.text,
                    a: double.parse(amountValue.text),
                    d: selectedDate,
                    c: selectedIcon);
              },
              child: Text(
                "submit",
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}

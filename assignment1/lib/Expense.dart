import 'myCategory.dart';

class Expense {
  String id;
  String title;
  double amount;
  DateTime date;
  MyCategory category;
  Expense(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date,
      required this.category});
}

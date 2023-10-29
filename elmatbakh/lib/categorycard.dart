import 'package:flutter/material.dart';
import 'category.dart';

// ignore: must_be_immutable
class CategoryCard extends StatelessWidget {
  Category cat;
  CategoryCard({required this.cat});
  navigateToKitchenPage(BuildContext myContext) {
    Navigator.of(myContext)
        .pushNamed('/kitchenRoute', arguments: {'category': cat});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => navigateToKitchenPage(context),
      child: Container(
        child: Text(
          cat.title,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.deepOrange),
      ),
    );
  }
}

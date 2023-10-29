import 'dart:convert';

import 'package:elmatbakh/recipe.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'recipecard.dart';
import 'category.dart';
import 'recipelist.dart';

class KitchenScreen extends StatefulWidget {
  @override
  _KitchenScreenState createState() => _KitchenScreenState();
}

class _KitchenScreenState extends State<KitchenScreen> {
  bool vegeterianSwitch = false;
  bool veganSwitch = false;
  var recipesList = [];

  var prefs;
  Future<void> getSwitchStates() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      vegeterianSwitch = prefs.getBool('vgt') ?? false;
      veganSwitch = prefs.getBool('veg') ?? false;
      recipesList = prefs.getStringList('recipes') ?? originalRecipesList;
      try {
        recipesList = recipesList
            .map((jsonString) => Recipe.fromJson(json.decode(jsonString)))
            .toList();
      } catch (x) {}
    });
  }

  @override
  void initState() {
    getSwitchStates();
    super.initState();
  }

  void toggleFavorite(String id) {
    setState(() {
      Recipe recipe = recipesList.where((element) => element.id == id).first;
      recipe.isFavorite = !recipe.isFavorite;
      recipesList[recipesList.indexOf(recipe)] = recipe;
      updateFavsinPref();
    });
  }

  Future<void> updateFavsinPref() async {
    List<String> recipeJsonList =
        recipesList.map((recipe) => json.encode(recipe.toJson())).toList();
    await prefs.setStringList('recipes', recipeJsonList);
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, Category>;
    final category = routeArgs['category'];
    final recipesInThatCategory = recipesList.where((element) {
      return element.categoryId.contains(category!.id);
    }).toList();
    final filteredRecipes = recipesInThatCategory.where((element) {
      if (element.isVegeterian == false && vegeterianSwitch == true) {
        return false;
      } else if (element.isVegan == false && veganSwitch == true) {
        return false;
      } else
        return true;
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(category!.title),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return RecipeCard(
              rec: filteredRecipes[index], onToggleFavorite: toggleFavorite);
        },
        itemCount: filteredRecipes.length,
      ),
    );
  }
}

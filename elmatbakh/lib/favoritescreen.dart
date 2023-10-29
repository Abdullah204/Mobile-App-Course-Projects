import 'package:elmatbakh/recipecard.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'recipe.dart';
import 'dart:convert';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Recipe> recipesList = [];

  @override
  void initState() {
    _loadRecipesFromSharedPreferences();
    super.initState();
  }

  Future<void> _loadRecipesFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? recipesJsonList = prefs.getStringList('recipes');
    if (recipesJsonList != null) {
      List<Recipe> loadedRecipes = recipesJsonList
          .map((recipeJson) => Recipe.fromJson(
              Map<String, dynamic>.from(json.decode(recipeJson))))
          .toList();

      setState(() {
        recipesList = loadedRecipes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredRecipes =
        recipesList.where((element) => element.isFavorite).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Favourites"),
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

  void toggleFavorite(String id) {
    setState(() {
      Recipe recipe = recipesList.where((element) => element.id == id).first;
      recipe.isFavorite = !recipe.isFavorite;
      recipesList[recipesList.indexOf(recipe)] = recipe;
      updateFavsinPref();
    });
  }

  Future<void> updateFavsinPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> recipeJsonList =
        recipesList.map((recipe) => json.encode(recipe.toJson())).toList();
    await prefs.setStringList('recipes', recipeJsonList);
  }
}

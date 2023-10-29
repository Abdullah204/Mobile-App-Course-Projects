import 'dart:convert';

import 'package:elmatbakh/recipe.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'recipelist.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
      recipesList = recipesList
          .map((jsonString) => Recipe.fromJson(json.decode(jsonString)))
          .toList();
    });
  }

  Future<void> updateVGTinPref(val) async {
    prefs.setBool('vgt', val);
  }

  Future<void> updateVEGinPref(val) async {
    prefs.setBool('veg', val);
  }

  Future<void> updateFavsinPref() async {
    List<String> recipeJsonList =
        recipesList.map((recipe) => json.encode(recipe.toJson())).toList();
    await prefs.setStringList('recipes', recipeJsonList);
  }

  @override
  void initState() {
    getSwitchStates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Column(
          children: [
            SwitchListTile(
                title: Text('Vegeterian only'),
                subtitle: Text('switch to allow only vegeterian meals'),
                value: vegeterianSwitch,
                onChanged: (val) {
                  setState(() {
                    vegeterianSwitch = val;
                    updateVGTinPref(val);
                  });
                }),
            SwitchListTile(
                title: Text('Vegan only'),
                subtitle: Text('switch to allow only vegan meals'),
                value: veganSwitch,
                onChanged: (val) {
                  setState(() {
                    veganSwitch = val;
                    updateVEGinPref(val);
                  });
                }),
          ],
        ));
  }
}

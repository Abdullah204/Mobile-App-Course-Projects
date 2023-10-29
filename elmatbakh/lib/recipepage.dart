import 'package:elmatbakh/recipe.dart';
import 'package:flutter/material.dart';

class RecipePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, Recipe> recipeMap =
        ModalRoute.of(context)!.settings.arguments as Map<String, Recipe>;
    Recipe recipe = recipeMap['recipe']!;
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Recipe Image
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(recipe.imageURL),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Recipe Details
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Recipe Difficulty
                  Text(
                    'Difficulty: ${recipe.difficulty}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  // Recipe Ingredients
                  Text(
                    'Ingredients:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: recipe.ingredients.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.check),
                        title: Text(recipe.ingredients[index]),
                      );
                    },
                  ),
                  // Recipe Steps
                  SizedBox(height: 10),
                  Text(
                    'Steps:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(recipe.steps),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: false,
        child: FloatingActionButton(
          onPressed: () {
            // Handle favorite button tap, you can toggle isFavorite property here
            // recipe.isFavorite = !recipe.isFavorite;
          },
          child:
              Icon(recipe.isFavorite ? Icons.favorite : Icons.favorite_border),
        ),
      ),
    );
  }
}

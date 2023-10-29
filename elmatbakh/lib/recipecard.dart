import 'recipe.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RecipeCard extends StatelessWidget {
  Recipe rec;
  final Function onToggleFavorite;
  RecipeCard({required this.rec, required this.onToggleFavorite});
  void goToSpecificRecipe() {}
  Widget getDifficultyComponent(int diff) {
    var icon = Icons.hourglass_full;
    var text = 'Hard';
    if (diff == 1) {
      icon = Icons.check;
      text = 'Easy';
    }
    if (diff == 2) {
      icon = Icons.hourglass_empty;
      text = 'Medium';
    }
    return Row(
      children: [
        Icon(icon),
        SizedBox(width: 8),
        Text(text),
      ],
    );
  }

  Widget getVegetarianComponent(bool isVegeterian) {
    var icon = Icons.fastfood;
    var text = 'Non-Vegetarian';
    if (isVegeterian) {
      icon = Icons.local_pizza;
      text = 'Vegetarian';
    }
    return Row(
      children: [
        Icon(icon),
        SizedBox(width: 8),
        Text(text),
      ],
    );
  }

  Widget getVeganComponent(bool isVegan) {
    var icon = Icons.local_dining;
    var text = 'Non-Vegan';
    if (isVegan) {
      icon = Icons.local_florist;
      text = 'Vegan';
    }
    return Row(
      children: [
        Icon(icon),
        SizedBox(width: 8),
        Text(text),
      ],
    );
  }

  getDifficulty(int diff) {
    if (diff == 1) {
      return 'Easy';
    } else if (diff == 2) {
      return 'Medium';
    } else
      return 'Hard';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: goToSpecificRecipe,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(children: [
          // child 1 of column is image + title
          Stack(
            children: [
// child 1 of stack is the recipe image
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: Image.network(
                  rec.imageURL,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
// child 2 of stack is the recipe title

              Positioned.fill(
                bottom: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Container(
                    color: Colors.black38,
                    child: Center(
                      //color: Colors.black38,
                      child: Text(
                        rec.title,
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          // child 2 of colum is the white row
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                getDifficultyComponent(rec.difficulty),
                getVeganComponent(rec.isVegan),
                getVegetarianComponent(rec.isVegeterian),
                // Text(rec.isVegan ? 'Vegan' : 'Non-Vegan'),
                // Text(rec.isVegeterian ? 'Vegetarrian' : 'Non-Vegetarian'),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              onToggleFavorite(rec.id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: rec.isFavorite
                  ? Colors.red
                  : Colors.green, // Set button color to green
            ),
            child: Text(
              rec.isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed('/RecipePage', arguments: {'recipe': rec});
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black // Set button color to green
                ),
            child: Text(
              "View Recipe",
              style: TextStyle(color: Colors.white),
            ),
          )
        ]),
      ),
    );
  }
}

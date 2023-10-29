class Recipe {
  final String id;
  final String title;
  final List<String> categoryId;
  final int difficulty;
  final List<String> ingredients;
  final String steps;
  final bool isVegan;
  final bool isVegeterian;
  final String imageURL;
  bool isFavorite;
  Recipe(
      {required this.id,
      required this.title,
      required this.categoryId,
      required this.difficulty,
      required this.ingredients,
      required this.steps,
      required this.isVegan,
      required this.isVegeterian,
      required this.imageURL,
      required this.isFavorite});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'categoryId': categoryId,
      'difficulty': difficulty,
      'ingredients': ingredients,
      'steps': steps,
      'isVegan': isVegan,
      'isVegeterian': isVegeterian,
      'imageURL': imageURL,
      'isFavorite': isFavorite,
    };
  }

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      categoryId: List<String>.from(json['categoryId']),
      difficulty: json['difficulty'],
      ingredients: List<String>.from(json['ingredients']),
      steps: json['steps'],
      isVegan: json['isVegan'],
      isVegeterian: json['isVegeterian'],
      imageURL: json['imageURL'],
      isFavorite: json['isFavorite'],
    );
  }
}

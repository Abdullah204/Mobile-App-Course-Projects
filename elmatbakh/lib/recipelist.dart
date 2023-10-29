import 'recipe.dart';

var originalRecipesList = [
  Recipe(
      id: 'r1',
      title: 'Fattoush',
      categoryId: ['c3'],
      difficulty: 1,
      ingredients: ['Lettuce', 'Tomato', 'Summac', 'Onion', 'Olive oil'],
      steps: 'Mix all together',
      isVegan: true,
      isVegeterian: true,
      imageURL:
          'https://assets.bonappetit.com/photos/57af6bea53e63daf11a4e565/16:9/w_1280,%20c_limit/fattoush.jpg',
      isFavorite: false),
  Recipe(
      id: 'r2',
      title: 'Falafel',
      categoryId: ['c2', 'c3'],
      difficulty: 2,
      ingredients: ['Fava beans', 'Hummus', 'Spices', 'frying oil'],
      steps: 'Mix ingredients into balls and fry them',
      isVegan: true,
      isVegeterian: true,
      imageURL:
          'https://i2.wp.com/www.downshiftology.com/wp-content/uploads/2019/07/Falafel-11.jpg',
      isFavorite: false),
  Recipe(
      id: 'r3',
      title: 'Chicken Alfredo',
      categoryId: ['c1'],
      difficulty: 2,
      ingredients: ['pasta', 'chicken', 'alredo sauce'],
      steps: 'Boil pasta, prepare chicken and pour sauce over',
      isVegan: false,
      isVegeterian: false,
      imageURL:
          'https://bellyfull.net/wp-content/uploads/2021/02/Chicken-Alfredo-blog-4.jpg',
      isFavorite: false)
];

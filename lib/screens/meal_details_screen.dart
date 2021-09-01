import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailsScreen extends StatelessWidget {
  static const routeName = '/meal_detail';
  final Function _toggleFavorite;
  final Function _isMealFavorite;

  MealDetailsScreen(this._toggleFavorite,this._isMealFavorite);

  Widget buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.only(top: 12, left: 16),
      child: Text(
        title,
        style: Theme
            .of(context)
            .textTheme
            .headline6,
      ),
    );
  }

  Widget buildSectionContainer({Widget child}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      padding: EdgeInsets.all(10),
      height: 150,
      width: 300,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute
        .of(context)
        .settings
        .arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 240,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildSectionContainer(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    color: Theme
                        .of(context)
                        .accentColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(selectedMeal.ingredients[index]),
                    ),
                  );
                },
                itemCount: selectedMeal.ingredients.length,
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildSectionContainer(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        dense: true,
                        leading: CircleAvatar(
                          child: Text('${index + 1}'),
                        ),
                        title: Text(selectedMeal.steps[index]),
                      ),
                      Container(
                          width: 250,
                          child: Divider(
                            color: Colors.black,
                          )),
                    ],
                  );
                },
                itemCount: selectedMeal.steps.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              _toggleFavorite(mealId);
            },
            child: Icon(_isMealFavorite(mealId)? Icons.star:Icons.star_border),
          ),
          SizedBox(height: 8,),
          FloatingActionButton(
            onPressed: () {
              Navigator.pop(context, mealId);
            },
            child: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}

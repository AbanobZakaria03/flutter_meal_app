import 'package:flutter/material.dart';
import 'package:meal_app/widgets/meal_item.dart';
import '../models/meal.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Meal> _favoriteMeals;

  FavoritesScreen(this._favoriteMeals);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget._favoriteMeals.length > 0
          ? ListView.builder(
              itemBuilder: (context, index) {
                return MealItem(
                  title: widget._favoriteMeals[index].title,
                  id: widget._favoriteMeals[index].id,
                  imageUrl: widget._favoriteMeals[index].imageUrl,
                  duration: widget._favoriteMeals[index].duration,
                  complexity: widget._favoriteMeals[index].complexity,
                  affordability: widget._favoriteMeals[index].affordability,
                  refresh: () {
                    setState(() {});
                  },
                );
              },
              itemCount: widget._favoriteMeals.length,
            )
          : Center(
              child: Text('You have no favorites yet - start adding some!'),
            ),
    );
  }
}

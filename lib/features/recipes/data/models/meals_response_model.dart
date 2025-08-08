import 'package:recipe_finder/features/recipes/data/models/meal_model.dart';
import 'package:recipe_finder/features/recipes/domain/entities/recipe.dart';

class MealsResponseModel {
  final List<MealModel>? meals;

  MealsResponseModel({this.meals});

  factory MealsResponseModel.fromJson(Map<String, dynamic> json) {
    final mealsList = json['meals'] as List<dynamic>?;
    return MealsResponseModel(
      meals: mealsList?.map((e) => MealModel.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'meals': meals?.map((e) => e.toJson()).toList(),
      };

  bool get hasData => meals != null && meals!.isNotEmpty;

  int get mealsCount => meals?.length ?? 0;

  List<Recipe> toEntities() => meals?.map((e) => e.toEntity()).toList() ?? [];
}
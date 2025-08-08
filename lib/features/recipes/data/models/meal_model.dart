import 'package:recipe_finder/features/recipes/domain/entities/ingredient.dart';
import 'package:recipe_finder/features/recipes/domain/entities/recipe.dart';

class MealModel {
  final String? idMeal;
  final String? strMeal;
  final String? strMealThumb;
  final String? strCategory;
  final String? strArea;
  final String? strInstructions;
  final String? strTags;
  final String? strYoutube;
  final Map<String, dynamic> ingredientsMap;

  MealModel({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
    required this.strCategory,
    required this.strArea,
    required this.strInstructions,
    required this.strTags,
    required this.strYoutube,
    required this.ingredientsMap,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    final ingredientsMap = <String, dynamic>{};
    for (var i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'] as String?;
      final measure = json['strMeasure$i'] as String?;
      if (ingredient != null && ingredient.isNotEmpty && measure != null) {
        ingredientsMap[ingredient] = measure;
      }
    }
    return MealModel(
      idMeal: json['idMeal'] as String?,
      strMeal: json['strMeal'] as String?,
      strMealThumb: json['strMealThumb'] as String?,
      strCategory: json['strCategory'] as String?,
      strArea: json['strArea'] as String?,
      strInstructions: json['strInstructions'] as String?,
      strTags: json['strTags'] as String?,
      strYoutube: json['strYoutube'] as String?,
      ingredientsMap: ingredientsMap,
    );
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'idMeal': idMeal,
      'strMeal': strMeal,
      'strMealThumb': strMealThumb,
      'strCategory': strCategory,
      'strArea': strArea,
      'strInstructions': strInstructions,
      'strTags': strTags,
      'strYoutube': strYoutube,
    };
    var i = 1;
    for (final entry in ingredientsMap.entries) {
      json['strIngredient$i'] = entry.key;
      json['strMeasure$i'] = entry.value;
      i++;
    }
    return json;
  }

  List<Ingredient> get ingredients => ingredientsMap.entries
      .map((e) => Ingredient(name: e.key, measure: e.value as String))
      .toList();

  List<String> get tags => strTags?.split(',').where((tag) => tag.isNotEmpty).toList() ?? [];

  Recipe toEntity() => Recipe(
        id: idMeal ?? '',
        name: strMeal ?? 'Unknown Recipe',
        thumbnailUrl: strMealThumb ?? '',
        category: strCategory ?? 'Unknown Category',
        area: strArea ?? 'Unknown Area',
        instructions: strInstructions ?? 'No instructions available',
        ingredients: ingredients,
        tags: tags,
        youtubeUrl: strYoutube,
      );
}
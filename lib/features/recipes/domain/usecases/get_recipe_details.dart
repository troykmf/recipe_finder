import 'package:flutter/material.dart';
import 'package:recipe_finder/core/error/failures.dart';
import 'package:recipe_finder/core/util/result.dart';
import 'package:recipe_finder/features/recipes/domain/entities/recipe.dart';
import 'package:recipe_finder/features/recipes/domain/repositories/recipe_repository.dart';

class GetRecipeDetails {
  final RecipeRepository repository;

  GetRecipeDetails(this.repository);

  Future<Result<Recipe, AppFailure>> call(String id) async {
    try {
      if (id.trim().isEmpty) {
        return Failure(NoResultsFailure(message: 'Recipe ID cannot be empty'));
      }
      return await repository.getRecipeDetails(id.trim());
    } catch (e, stackTrace) {
      debugPrint('Error in GetRecipeDetails: $e\nStack trace: $stackTrace');
      return Failure(ServerFailure(message: 'Unexpected error in get details: $e'));
    }
  }
}
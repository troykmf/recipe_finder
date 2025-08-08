
import 'package:flutter/material.dart';
import 'package:recipe_finder/core/error/failures.dart';
import 'package:recipe_finder/core/util/result.dart';
import 'package:recipe_finder/features/recipes/domain/entities/recipe.dart';
import 'package:recipe_finder/features/recipes/domain/repositories/recipe_repository.dart';

class SearchRecipes {
  final RecipeRepository repository;

  SearchRecipes(this.repository);

  Future<Result<List<Recipe>, AppFailure>> call(String query) async {
    try {
      if (query.trim().isEmpty) {
        return Failure(NoResultsFailure(message: 'Search query cannot be empty'));
      }
      return await repository.searchRecipes(query.trim());
    } catch (e, stackTrace) {
      debugPrint('Error in SearchRecipes: $e\nStack trace: $stackTrace');
      return Failure(ServerFailure(message: 'Unexpected error in search: $e'));
    }
  }
}

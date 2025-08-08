import 'package:flutter/material.dart';
import 'package:recipe_finder/core/error/exceptions.dart';
import 'package:recipe_finder/core/error/failures.dart';
import 'package:recipe_finder/core/util/result.dart';
import 'package:recipe_finder/features/recipes/data/data_sources/recipe_remote_data_source.dart';
import 'package:recipe_finder/features/recipes/domain/entities/recipe.dart';
import 'package:recipe_finder/features/recipes/domain/repositories/recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDataSource remoteDataSource;

  RecipeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Result<List<Recipe>, AppFailure>> searchRecipes(String query) async {
    try {
      final response = await remoteDataSource.searchRecipes(query);
      final recipes = response.toEntities();
      return Success(recipes);
    } catch (e, stackTrace) {
      debugPrint(
        'Error in RecipeRepository.searchRecipes: $e\nStack trace: $stackTrace',
      );
      return _mapExceptionToFailure(e);
    }
  }

  @override
  Future<Result<Recipe, AppFailure>> getRecipeDetails(String id) async {
    try {
      final response = await remoteDataSource.getRecipeDetails(id);
      final recipes = response.toEntities();
      if (recipes.isEmpty) {
        throw const NoResultsException(
          message: 'No recipe found for the given ID',
        );
      }
      return Success(recipes.first);
    } catch (e, stackTrace) {
      debugPrint(
        'Error in RecipeRepository.getRecipeDetails: $e\nStack trace: $stackTrace',
      );
      return _mapExceptionToFailure(e);
    }
  }

  Result<T, AppFailure> _mapExceptionToFailure<T>(dynamic e) {
    if (e is ServerException) {
      return Failure(
        ServerFailure(message: e.message, statusCode: e.statusCode),
      );
    } else if (e is NetworkException) {
      return Failure(NetworkFailure(message: e.message));
    } else if (e is NoResultsException) {
      return Failure(NoResultsFailure(message: e.message));
    } else {
      return Failure(ServerFailure(message: 'Unexpected error: $e'));
    }
  }
}

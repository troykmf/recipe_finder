import 'package:flutter/material.dart';
import 'package:recipe_finder/core/error/exceptions.dart';
import 'package:recipe_finder/core/network/api_constants.dart';
import 'package:recipe_finder/core/network/network_client.dart';
import 'package:recipe_finder/features/recipes/data/models/meals_response_model.dart';

abstract class RecipeRemoteDataSource {
  Future<MealsResponseModel> searchRecipes(String query);
  Future<MealsResponseModel> getRecipeDetails(String id);
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  final NetworkClient networkClient;

  RecipeRemoteDataSourceImpl(this.networkClient);

  @override
  Future<MealsResponseModel> searchRecipes(String query) async {
    try {
      final response = await networkClient.get(
        ApiConstants.searchByName,
        queryParams: {ApiConstants.querySearch: query},
      );
      return MealsResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      debugPrint('Error in searchRecipes: $e\nStack trace: $stackTrace');
      if (e is ServerException || e is NetworkException || e is NoResultsException) {
        rethrow;
      }
      throw ServerException(message: 'Unexpected error in searchRecipes: $e');
    }
  }

  @override
  Future<MealsResponseModel> getRecipeDetails(String id) async {
    try {
      final response = await networkClient.get(
        ApiConstants.lookupById,
        queryParams: {ApiConstants.queryId: id},
      );
      return MealsResponseModel.fromJson(response);
    } catch (e, stackTrace) {
      debugPrint('Error in getRecipeDetails: $e\nStack trace: $stackTrace');
      if (e is ServerException || e is NetworkException || e is NoResultsException) {
        rethrow;
      }
      throw ServerException(message: 'Unexpected error in getRecipeDetails: $e');
    }
  }
}
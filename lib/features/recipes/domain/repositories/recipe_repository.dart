import 'package:recipe_finder/core/error/failures.dart';
import 'package:recipe_finder/core/util/result.dart';
import 'package:recipe_finder/features/recipes/domain/entities/recipe.dart';


abstract class RecipeRepository {
  Future<Result<List<Recipe>, AppFailure>> searchRecipes(String query);
  Future<Result<Recipe, AppFailure>> getRecipeDetails(String id);
}

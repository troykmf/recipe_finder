import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_finder/core/network/network_client.dart';
import 'package:recipe_finder/features/recipes/data/data_sources/recipe_remote_data_source.dart';
import 'package:recipe_finder/features/recipes/data/repositories/recipe_repository_impl.dart';
import 'package:recipe_finder/features/recipes/domain/entities/recipe.dart';
import 'package:recipe_finder/features/recipes/domain/repositories/recipe_repository.dart';
import 'package:recipe_finder/features/recipes/domain/usecases/get_recipe_details.dart';
import 'package:recipe_finder/features/recipes/domain/usecases/search_recipes.dart';

final networkClientProvider = Provider<NetworkClient>((ref) {
  final networkClient = NetworkClient(http.Client());
  ref.onDispose(() {
    networkClient.dispose();
  });
  return networkClient;
});

final recipeDataSourceProvider = Provider<RecipeRemoteDataSource>(
  (ref) => RecipeRemoteDataSourceImpl(ref.watch(networkClientProvider)),
);

final recipeRepositoryProvider = Provider<RecipeRepository>(
  (ref) => RecipeRepositoryImpl(ref.watch(recipeDataSourceProvider)),
);

final searchRecipesUseCaseProvider = Provider<SearchRecipes>(
  (ref) => SearchRecipes(ref.watch(recipeRepositoryProvider)),
);

final getRecipeDetailsUseCaseProvider = Provider<GetRecipeDetails>(
  (ref) => GetRecipeDetails(ref.watch(recipeRepositoryProvider)),
);

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchRecipesProvider = FutureProvider<List<Recipe>>((ref) async {
  final query = ref.watch(searchQueryProvider).trim();
  if (query.isEmpty) return [];
  final useCase = ref.watch(searchRecipesUseCaseProvider);
  final result = await useCase(query);
  return result.isSuccess ? result.value! : throw result.error!;
});

final recipeDetailsProvider = FutureProvider.family<Recipe, String>((
  ref,
  id,
) async {
  final useCase = ref.watch(getRecipeDetailsUseCaseProvider);
  final result = await useCase(id);
  return result.isSuccess ? result.value! : throw result.error!;
});

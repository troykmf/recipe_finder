import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_finder/core/error/failures.dart';
import 'package:recipe_finder/features/recipes/presentation/providers/recipe_providers.dart';
import 'package:recipe_finder/features/recipes/presentation/widgets/error_widget.dart';
import 'package:recipe_finder/features/recipes/presentation/widgets/recipe_card.dart';

class RecipeSearchPage extends ConsumerWidget {
  const RecipeSearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchQueryProvider);
    final recipesAsync = ref.watch(searchRecipesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search for Recipes'),
        // backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search recipes (e.g., chicken)',

                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade100.withOpacity(0.7),
              ),
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value;
              },
            ),
          ),
          Expanded(
            child: recipesAsync.when(
              data: (recipes) {
                if (recipes.isEmpty && searchQuery.trim().isNotEmpty) {
                  return const CustomErrorWidget(
                    failure: NoResultsFailure(
                      message: 'No recipes found for your query',
                    ),
                  );
                }
                return recipes.isEmpty
                    ? const Center(
                        child: Text('Enter a search term to find recipes'),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 16),
                        itemCount: recipes.length,
                        itemBuilder: (context, index) {
                          final recipe = recipes[index];
                          return RecipeCard(
                            recipe: recipe,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/recipe_details',
                                arguments: recipe.id,
                              );
                            },
                          );
                        },
                      );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) => CustomErrorWidget(
                failure: error is AppFailure
                    ? error
                    : NoResultsFailure(message: 'No recipe found'),
              ),
              skipError: true,
            ),
          ),
        ],
      ),
    );
  }
}

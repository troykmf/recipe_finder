import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_finder/core/error/failures.dart';
import 'package:recipe_finder/features/recipes/presentation/providers/recipe_providers.dart';

class CustomErrorWidget extends ConsumerWidget {
  final AppFailure failure;

  const CustomErrorWidget({super.key, required this.failure});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(Icons.error_outline, size: 48, color: Colors.grey[600]),
            const SizedBox(height: 16),
            Text(
              _getErrorMessage(failure, ref),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[700],
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  String _getErrorMessage(AppFailure failure, WidgetRef ref) {
    final searchQuery = ref.watch(searchQueryProvider).trim();
    if (failure is ServerFailure) {
      return 'Server error: ${failure.message}${failure.statusCode != null ? ' (Code: ${failure.statusCode})' : ''}';
    } else if (failure is NetworkFailure) {
      return 'No internet connection. Please check your network and try again.';
    } else if (failure is NoResultsFailure) {
      return 'No recipe found for "$searchQuery"';
    } else {
      return 'An unexpected error occurred: ${failure.message}';
    }
  }
}

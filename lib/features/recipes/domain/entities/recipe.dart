
import 'package:recipe_finder/features/recipes/domain/entities/ingredient.dart';

class Recipe {
  final String id;
  final String name;
  final String thumbnailUrl;
  final String category;
  final String area;
  final String instructions;
  final List<Ingredient> ingredients;
  final List<String> tags;
  final String? youtubeUrl;

  const Recipe({
    required this.id,
    required this.name,
    required this.thumbnailUrl,
    required this.category,
    required this.area,
    required this.instructions,
    required this.ingredients,
    required this.tags,
    this.youtubeUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Recipe &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          thumbnailUrl == other.thumbnailUrl &&
          category == other.category &&
          area == other.area &&
          instructions == other.instructions &&
          ingredients == other.ingredients &&
          tags == other.tags &&
          youtubeUrl == other.youtubeUrl;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      thumbnailUrl.hashCode ^
      category.hashCode ^
      area.hashCode ^
      instructions.hashCode ^
      ingredients.hashCode ^
      tags.hashCode ^
      youtubeUrl.hashCode;
}
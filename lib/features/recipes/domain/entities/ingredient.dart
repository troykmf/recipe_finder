class Ingredient {
  final String name;
  final String measure;

  const Ingredient({
    required this.name,
    required this.measure,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Ingredient &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          measure == other.measure;

  @override
  int get hashCode => name.hashCode ^ measure.hashCode;
}
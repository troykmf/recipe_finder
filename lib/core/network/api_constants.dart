class ApiConstants {
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1';
  static const String searchByName = '/search.php';
  static const String lookupById = '/lookup.php';
  static const String randomMeal = '/random.php';
  static const String categories = '/categories.php';
  static const String listCategories = '/list.php?c=list';
  static const String listAreas = '/list.php?a=list';
  static const String listIngredients = '/list.php?i=list';
  static const String filterByIngredient = '/filter.php';

  static const String querySearch = 's';
  static const String queryLetter = 'f';
  static const String queryId = 'i';
  static const String queryIngredient = 'i';
}
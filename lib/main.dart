import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_finder/features/recipes/presentation/pages/recipe_details_page.dart';
import 'package:recipe_finder/features/recipes/presentation/pages/recipe_search_page.dart';

void main() {
  runApp(const ProviderScope(child: RecipeApp()));
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.lightBlue.shade700,
        primarySwatch: Colors.blue,
        useMaterial3: true,
        fontFamily: GoogleFonts.lato().fontFamily,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const RecipeSearchPage(),
        '/recipe_details': (context) => RecipeDetailsPage(
          recipeId: ModalRoute.of(context)!.settings.arguments as String,
        ),
      },
    );
  }
}

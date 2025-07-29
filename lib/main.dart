import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_input/ui/home_screen.dart';

void main() {
    runApp(
        ProviderScope(child: const MyApp())
    );
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});

    // This widgets is the root of your application.
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Dio',
            theme: ThemeData.dark().copyWith(
                colorScheme: ColorScheme.fromSeed(
                    seedColor: const Color.fromARGB(255, 147, 229, 250),
                    brightness: Brightness.dark,
                    surface: const Color.fromARGB(255, 42, 51, 59)
                ),
                scaffoldBackgroundColor: const Color.fromARGB(255, 50, 58, 60)
            ),
            home: HomeScreen()
        );
    }
}
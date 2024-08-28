import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mynotes/providers/note.dart';
import 'package:mynotes/screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => NoteProvider())],
    child: const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: ThemeData(
        useMaterial3: true,

        // Define the default brightness and colors.
        colorScheme: const ColorScheme.light(
          surface: Colors.white,
          brightness: Brightness.dark,
        ),

        textTheme: TextTheme(
          titleLarge: GoogleFonts.inter(),
          bodyLarge: GoogleFonts.inter(),
          bodyMedium: GoogleFonts.inter(),
          bodySmall: GoogleFonts.inter(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mynotes/providers/note.dart';
import 'package:mynotes/screens/home.dart';
import 'package:mynotes/services/note.dart';
import 'package:provider/provider.dart';

void main() {
  NoteService noteService = NoteService();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NoteProvider(noteService))
    ],
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
      darkTheme: ThemeData(
        useMaterial3: true,

        // Define the default brightness and colors.
        cardColor: const Color(0xffffc93c),

        colorScheme: const ColorScheme.light(
            brightness: Brightness.dark,
            error: Color(0xFFE3170A),
            primary: Color(0xFF212121),
            secondary: Color(0xFFE1E1E1)),

        textTheme: TextTheme(
          titleLarge: GoogleFonts.inter(),
          bodyLarge: GoogleFonts.inter(),
          bodyMedium: GoogleFonts.inter(),
          bodySmall: GoogleFonts.inter(),
        ),
      ),
      theme: ThemeData(
        useMaterial3: true,

        // Define the default brightness and colors.
        cardColor: const Color(0xffffc93c),

        colorScheme: const ColorScheme.light(
            brightness: Brightness.dark,
            error: Color(0xFFE3170A),
            primary: Color(0xff2974ff),
            secondary: Color(0xFFFFFFFF)),

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

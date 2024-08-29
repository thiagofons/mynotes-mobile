import 'package:flutter/material.dart';
import 'package:mynotes/models/note.dart';
import 'package:mynotes/providers/note.dart';
import 'package:mynotes/widgets/note/add_note_dialog.dart';
import 'package:provider/provider.dart';

class AddNoteButton extends StatefulWidget {
  const AddNoteButton({super.key});

  @override
  State<AddNoteButton> createState() => _AddNoteButtonState();
}

class _AddNoteButtonState extends State<AddNoteButton> {
  final Map<String, TextEditingController> textControllers = {
    "title": TextEditingController(),
    "content": TextEditingController(),
  };

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textControllers.forEach((key, value) {
      value.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    createNote() {
      Provider.of<NoteProvider>(context, listen: false).createNote(NoteModel(
          title: textControllers["title"]?.text,
          content: textControllers["content"]?.text));
      Navigator.of(context).pop();

      setState(() {});
    }

    createNoteDialog() {
      showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black54,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return AddNoteDialog(
            textControllers: textControllers,
          );
        },
        transitionBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          );
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1), // Start from the bottom
              end: Offset.zero, // End at the center
            ).animate(curvedAnimation),
            child: child,
          );
        },
      ).then((_) {
        // Clear the text when the dialog is closed
        textControllers["title"]!.clear();
        textControllers["content"]!.clear();
      });
    }

    return ElevatedButton(
        onPressed: () => createNoteDialog(),
        style: const ButtonStyle(
          surfaceTintColor: WidgetStatePropertyAll(Color(0x22ffffff)),
          shadowColor: WidgetStatePropertyAll(Color(0x22a1a1a1)),
          overlayColor: WidgetStatePropertyAll(Color(0x22000000)),
          minimumSize: WidgetStatePropertyAll(Size(64, 64)),
          elevation: WidgetStatePropertyAll(24),
          alignment: Alignment.center,
          enableFeedback: true,
          fixedSize: WidgetStatePropertyAll(Size.square(48)),
          padding: WidgetStatePropertyAll(EdgeInsets.all(12)),
          backgroundColor: WidgetStatePropertyAll(Colors.white),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
          ),
        ),
        child: Container(
          decoration: const BoxDecoration(),
          child: const Icon(
            Icons.add_rounded,
            size: 24,
            color: Colors.black,
          ),
        ));
  }
}

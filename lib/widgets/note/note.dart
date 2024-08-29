import 'package:flutter/material.dart';
import 'package:mynotes/models/note.dart';
import 'package:mynotes/providers/note.dart';
import 'package:mynotes/widgets/note/edit_note_dialog.dart';
import 'package:provider/provider.dart';

class Note extends StatefulWidget {
  final NoteModel note;

  const Note({super.key, required this.note});

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    removeNote() {
      setState(() {
        Provider.of<NoteProvider>(context, listen: false)
            .removeNote(widget.note);
      });
    }

    viewNoteDialog() {
      showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black54,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return EditNoteDialog(note: widget.note);
        },
        transitionBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          );
          return ScaleTransition(
            scale: Tween<double>(
              begin: 0.5, // Start slightly smaller
              end: 1.0, // Grow to full size
            ).animate(curvedAnimation),
            child: child,
          );
        },
      );
    }

    return GestureDetector(
      onTap: () => viewNoteDialog(),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 300,
          maxHeight: 300,
        ),
        padding: const EdgeInsets.all(12), // Padding igual em todos os lados
        decoration: const BoxDecoration(
          color: Color(0xffffc93c),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    widget.note.title ?? "",
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow:
                        TextOverflow.ellipsis, // Limita o título a uma linha
                  ),
                ),
                IconButton(
                  onPressed: () => removeNote(),
                  icon: Icon(
                    Icons.remove,
                    size: 24,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8), // Espaço entre o título e o conteúdo
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  widget.note.content ?? "",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

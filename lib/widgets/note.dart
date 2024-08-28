import 'package:flutter/material.dart';
import 'package:mynotes/models/note.dart';
import 'package:mynotes/providers/note.dart';
import 'package:provider/provider.dart';

class Note extends StatefulWidget {
  final NoteModel data;

  const Note({super.key, required this.data});

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  @override
  Widget build(BuildContext context) {
    removeNote() {
      Provider.of<NoteProvider>(context, listen: false)
          .removeNote(widget.data.id!);
    }

    viewNoteDialog() {
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              backgroundColor: Theme.of(context).cardColor,
              child: Container(
                constraints:
                    const BoxConstraints(maxWidth: 300, maxHeight: 300),
                padding: const EdgeInsets.fromLTRB(12, 24, 12, 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          widget.data.title ?? "",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          widget.data.content ?? "",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        // Close dialog
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 6.0),
                            child: ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              style: ElevatedButton.styleFrom(
                                overlayColor: Colors.black12,
                                backgroundColor: const Color(0xff212121),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text(
                                "Voltar",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        // Save note
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: ElevatedButton(
                              onPressed: () => {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                overlayColor: Colors.black12,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.edit,
                                    size: 16,
                                    color: Color(0xff212121),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text("Editar",
                                      style:
                                          TextStyle(color: Color(0xff212121)))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          });
      /**
      Provider.of<NoteProvider>(context, listen: false)
          .createNote(NoteModel(title: ""));
      */
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
                    widget.data.title ?? "",
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
                  widget.data.content ?? "",
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

import 'package:flutter/material.dart';
import 'package:mynotes/models/note.dart';
import 'package:mynotes/providers/note.dart';
import 'package:provider/provider.dart';

class AddNoteDialog extends StatefulWidget {
  final Map<String, TextEditingController> textControllers;

  const AddNoteDialog({super.key, required this.textControllers});

  @override
  State<AddNoteDialog> createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends State<AddNoteDialog> {
  @override
  Widget build(BuildContext context) {
    createNote() {
      setState(() {
        Provider.of<NoteProvider>(context, listen: false).createNote(NoteModel(
            title: widget.textControllers["title"]?.text,
            content: widget.textControllers["content"]?.text));
      });
      Navigator.of(context).pop();
    }

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: Theme.of(context).cardColor,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 300, maxHeight: 300),
        padding: const EdgeInsets.fromLTRB(12, 24, 12, 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TextField(
                  controller: widget.textControllers["title"],
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor: const Color(0xff212121),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    label: Text("Título..."),
                    alignLabelWithHint: false,
                    border: InputBorder.none,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: widget.textControllers["content"],
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor: const Color(0xff212121),
                  minLines: 1,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    label: Text("Conteúdo..."),
                    alignLabelWithHint: false,
                    border: InputBorder.none,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
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
                      onPressed: () => createNote(),
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
                            Icons.check_circle,
                            size: 16,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text("Salvar",
                              style: TextStyle(color: Color(0xff212121)))
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
  }
}

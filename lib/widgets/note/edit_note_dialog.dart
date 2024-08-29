import 'package:flutter/material.dart';
import 'package:mynotes/models/note.dart';
import 'package:mynotes/providers/note.dart';
import 'package:provider/provider.dart';

class EditNoteDialog extends StatefulWidget {
  final NoteModel note;

  const EditNoteDialog({super.key, required this.note});

  @override
  State<EditNoteDialog> createState() => _EditNoteDialogState();
}

class _EditNoteDialogState extends State<EditNoteDialog> {
  bool isEditing = false;
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title ?? "");
    _contentController = TextEditingController(text: widget.note.content ?? "");
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    save() {
      setState(() {
        Provider.of<NoteProvider>(context, listen: false).updateNote(NoteModel(
            id: widget.note.id,
            title: _titleController.text,
            content: _contentController.text));
        isEditing = false;
      });
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    isEditing
                        ? TextField(
                            controller: _titleController,
                            style: Theme.of(context).textTheme.titleMedium,
                            textCapitalization: TextCapitalization.sentences,
                            textAlign: TextAlign.start,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              enabledBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              label: Text("Título..."),
                              alignLabelWithHint: false,
                              border: InputBorder.none,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                            ),
                          )
                        : Text(
                            _titleController.text,
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                    const SizedBox(height: 12),
                    isEditing
                        ? TextField(
                            controller: _contentController,
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyMedium,
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                            ),
                          )
                        : Text(
                            _contentController.text,
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 12,
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
                // Save or edit note
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (isEditing) {
                          // Salvar as alterações
                          save();
                        } else {
                          setState(() {
                            isEditing = true;
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        overlayColor: Colors.black12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            isEditing ? Icons.save : Icons.edit,
                            size: 16,
                            color: const Color(0xff212121),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            isEditing ? "Salvar" : "Editar",
                            style: const TextStyle(color: Color(0xff212121)),
                          ),
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

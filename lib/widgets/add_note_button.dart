import 'package:flutter/material.dart';
import 'package:mynotes/models/note.dart';
import 'package:mynotes/providers/note.dart';
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
    }

    createNoteDialog() {
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
                  children: [
                    Column(
                      children: [
                        TextField(
                          controller: textControllers["title"],
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
                          controller: textControllers["content"],
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
          }).then((_) {
        // Clear the text when the dialog is closed
        textControllers["title"]!.clear();
        textControllers["content"]!.clear();
      });
      /**
      Provider.of<NoteProvider>(context, listen: false)
          .createNote(NoteModel(title: ""));
      */
    }

    return ElevatedButton(
        onPressed: () => createNoteDialog(),
        style: const ButtonStyle(
          surfaceTintColor: WidgetStatePropertyAll(Color(0x22ffffff)),
          shadowColor: WidgetStatePropertyAll(Color(0x22ffffff)),
          overlayColor: WidgetStatePropertyAll(Color(0x22000000)),
          minimumSize: WidgetStatePropertyAll(Size(64, 64)),
          elevation: WidgetStatePropertyAll(12),
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

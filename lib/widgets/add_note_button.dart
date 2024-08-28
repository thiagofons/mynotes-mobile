import 'package:flutter/material.dart';

class AddNoteButton extends StatelessWidget {
  const AddNoteButton({super.key});

  @override
  Widget build(BuildContext context) {
    addNote() {
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
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(label: Text("Título")),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        ElevatedButton(onPressed: () {}, child: Container()),
                        ElevatedButton(onPressed: () {}, child: Container())
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

    return ElevatedButton(
        onPressed: () => addNote(),
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

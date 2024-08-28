import 'package:flutter/material.dart';

class AddNoteButton extends StatelessWidget {
  const AddNoteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
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

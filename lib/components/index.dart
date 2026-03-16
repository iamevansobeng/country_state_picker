// PLACING ALL COMPONENTS IN A SIGNLE FILE SINCE THEY ARE BASICALLY JUST A FEW LINES OF CODE
//  NOT WORTH CREATING A SEPARATE FILE FOR EACH COMPONENT
import 'package:flutter/material.dart';

/// Lightweight label widget used above dropdown fields.
class Label extends StatelessWidget {
  /// Creates a [Label].
  const Label({
    Key? key,
    required this.title,
  }) : super(key: key);

  /// Label text.
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
      child: Text(
        title,
        style:
            const TextStyle(fontWeight: FontWeight.w500, color: Colors.black54),
      ),
    );
  }
}

/// Returns a [Text] widget for hint content.
Text hintText(String text, {TextStyle? style}) {
  return Text(text, style: style);
}

import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  // Below can be `const` as it can be cached as the variable text will not
  // change after the first run as it is final
  const StyledText(this.text, {super.key});

  // We can add final as we don't want to change the value
  final String text;

  @override
  Widget build(context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 28,
      ),
    );
  }
}

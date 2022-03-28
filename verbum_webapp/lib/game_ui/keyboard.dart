import 'package:flutter/material.dart';

class Keyboard extends StatelessWidget {
  final firstRow = const ['A', 'Z', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'];
  final secondRow = const ['Q', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'M'];
  final thirdRow = const ['W', 'X', 'C', 'V', 'B', 'N'];
  final void Function(String) onKeyTap;
  final void Function()? onBackspaceTap;
  final void Function()? onSubmitTap;
  const Keyboard({Key? key, required this.onKeyTap, required this.onBackspaceTap, required this.onSubmitTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: firstRow.map((e) => KeyTouch(letter: e, onTap: onKeyTap)).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: secondRow.map((e) => KeyTouch(letter: e, onTap: onKeyTap)).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: KeyDelete(onTap: onBackspaceTap)),
            ...thirdRow.map((e) => KeyTouch(letter: e, onTap: onKeyTap)).toList(),
            Expanded(child: KeySubmit(onTap: onSubmitTap)),
          ],
        ),
      ],
    );
  }
}

class KeyTouch extends StatelessWidget {
  final String letter;
  final void Function(String) onTap;
  const KeyTouch({Key? key, required this.letter, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(letter),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          letter,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class KeyDelete extends StatelessWidget {
  final void Function()? onTap;
  const KeyDelete({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: const Icon(Icons.backspace),
    );
  }
}

class KeySubmit extends StatelessWidget {
  final void Function()? onTap;
  const KeySubmit({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: const Icon(Icons.check),
    );
  }
}

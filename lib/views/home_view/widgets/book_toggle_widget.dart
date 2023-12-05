import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';

class SwitchBookWidget extends StatelessWidget {
  final bool positive;
  final void Function(bool)? onChanged;
  const SwitchBookWidget({
    super.key,
    required this.positive,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch<bool>.dual(
      current: positive,
      first: false,
      second: true,
      spacing: 40,
      style: const ToggleStyle(
        borderColor: Colors.transparent,
      ),
      borderWidth: 0,
      height: 32,
      onChanged: onChanged,
      styleBuilder: (b) => ToggleStyle(
          indicatorColor: b ? Colors.transparent : Colors.transparent),
      iconBuilder: (value) => value
          ? const Icon(
              Icons.auto_stories,
              color: Colors.blueAccent,
              size: 30,
            )
          : const Icon(
              Icons.favorite,
              color: Colors.red,
              size: 30,
            ),
      textBuilder: (value) => value
          ? const Center(
              child: Text(
              'Livros',
              style: TextStyle(fontWeight: FontWeight.w500),
            ))
          : const Center(
              child: Text(
              'Favoritos',
              style: TextStyle(fontWeight: FontWeight.w500),
            )),
    );
  }
}

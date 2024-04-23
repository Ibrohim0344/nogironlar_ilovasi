import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String buttonText;
  final Color? backgroundColor;
  final VoidCallback onPressed;
  final double vertPadding;
  final double? width;

  const MainButton(
    this.buttonText, {
    required this.onPressed,
    this.backgroundColor = Colors.cyanAccent,
    this.vertPadding = 34,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.black,
        fixedSize: width != null ? Size(width!, 80) : null,
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: width == null ? vertPadding : 0,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: const TextStyle(
          fontSize: 20,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

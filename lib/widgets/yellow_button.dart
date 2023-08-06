import 'package:flutter/material.dart';

class YellowButton extends StatelessWidget {
  final Function() onPressed;
  final double width;
  final String label;
  const YellowButton({
    super.key,
    required this.width,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: MediaQuery.of(context).size.width * width,
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(25),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}

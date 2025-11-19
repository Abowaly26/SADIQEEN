import 'package:flutter/material.dart';


class CreateNewAccount extends StatelessWidget {
  const CreateNewAccount({super.key, required this.topText, required this.buttomText, required this.onPressed});
  final String topText;
  final String buttomText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          topText,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttomText,
            style: TextStyle(
              color: Color(0xFF1A237E),
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sadiqeen/core/theming/styles.dart';

class CreateNewAccount extends StatelessWidget {
  const CreateNewAccount({
    super.key,
    required this.topText,
    required this.buttomText,
    required this.onPressed,
  });
  final String topText;
  final String buttomText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(topText, style: TextStyles.font18GrayMedium),
        TextButton(
          onPressed: onPressed,
          child: Text(buttomText, style: TextStyles.font18IndigoBlueSemiBold),
        ),
      ],
    );
  }
}

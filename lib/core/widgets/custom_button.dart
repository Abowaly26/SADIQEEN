import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sadiqeen/core/theming/styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    this.isLoading,
    required this.text,
  });
  final VoidCallback? onPressed;
  final bool? isLoading;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: isLoading == true ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A237E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: isLoading == true
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(text, style: TextStyles.font18YellowBold),
      ),
    );
    ;
  }
}

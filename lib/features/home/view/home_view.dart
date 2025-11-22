import 'package:flutter/material.dart';
import 'package:sadiqeen/features/home/view/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: SafeArea(child: const HomeViewBody()),
      ),
    );
  }
}

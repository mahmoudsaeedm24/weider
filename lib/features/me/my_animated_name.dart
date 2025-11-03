import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class MyAnimatedName extends StatefulWidget {
  const MyAnimatedName({super.key});

  @override
  State<MyAnimatedName> createState() => _MyAnimatedNameState();
}

class _MyAnimatedNameState extends State<MyAnimatedName> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // بعد ما الودجت تبني، فعّل الظهور التدريجي
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() => _opacity = 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOut,
      child: Text(
        'Mahmoud Saeed',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.secondary,
        ),
      ),
    );
  }
}

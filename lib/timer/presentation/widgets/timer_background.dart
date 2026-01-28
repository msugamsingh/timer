import 'package:flutter/material.dart';
import 'package:timer/values/app_colors.dart';
import 'package:timer/values/app_theme.dart';

class TimerBackground extends StatelessWidget {
  const TimerBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final timerTheme = Theme.of(context).extension<TimerTheme>()!;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: timerTheme.cardGradient,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 40,
            left: 20,
            child: Icon(
              Icons.star,
              color: AppColors.white.withValues(alpha: 0.1),
              size: 30,
            ),
          ),
          Positioned(
            top: 60,
            right: 30,
            child: Icon(
              Icons.star,
              color: AppColors.white.withValues(alpha: 0.1),
              size: 24,
            ),
          ),
          Positioned(
            bottom: 130,
            left: 28,
            child: Icon(
              Icons.star,
              color: AppColors.white.withValues(alpha: 0.1),
              size: 20,
            ),
          ),
          child,
        ],
      ),
    );
  }
}

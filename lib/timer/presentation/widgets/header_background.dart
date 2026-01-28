import 'package:flutter/material.dart';
import 'package:timer/values/app_theme.dart';
import 'package:timer/values/app_colors.dart';

class HeaderBackground extends StatelessWidget {
  const HeaderBackground({super.key});

  final _initCircle = 200;

  @override
  Widget build(BuildContext context) {
    final timerTheme = Theme.of(context).extension<TimerTheme>()!;

    return Container(
      height: 320,
      width: double.infinity,
      decoration: BoxDecoration(color: timerTheme.headerBackground),
      child: Stack(
        children: [
          Positioned(
            top: -40,
            left: -40,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white.withValues(alpha: 0.03),
              ),
            ),
          ),
          Positioned(
            top: -90,
            left: -90,
            child: Container(
              width: (_initCircle + 160).toDouble(),
              height: (_initCircle + 160).toDouble(),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white.withValues(alpha: 0.05),
              ),
            ),
          ),
          Positioned(
            top: -140,
            left: -140,
            child: Container(
              width: (_initCircle + (160 * 2)).toDouble(),
              height: (_initCircle + (160 * 2)).toDouble(),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white.withValues(alpha: 0.05),
              ),
            ),
          ),
          Positioned(
            top: -190,
            left: -190,
            child: Container(
              width: (_initCircle + (160 * 3)).toDouble(),
              height: (_initCircle + (160 * 3)).toDouble(),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white.withValues(alpha: 0.05),
              ),
            ),
          ),
          Positioned(
            top: -240,
            left: -240,
            child: Container(
              width: (_initCircle + (160 * 4)).toDouble(),
              height: (_initCircle + (160 * 4)).toDouble(),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white.withValues(alpha: 0.05),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

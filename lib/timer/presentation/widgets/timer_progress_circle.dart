import 'package:timer/values/app_colors.dart';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class TimerProgressCircle extends StatelessWidget {
  const TimerProgressCircle({
    super.key,
    required this.progress,
    required this.minutes,
    required this.seconds,
  });

  final double progress;
  final String minutes;
  final String seconds;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.0, end: progress),
        duration: const Duration(seconds: 1),
        curve: Curves.linear,
        builder: (context, value, child) {
          return CustomPaint(
            painter: _TimerPainter(
              progress: value,
              color: AppColors.white,
              backgroundColor: AppColors.white.withValues(alpha: 0.2),
            ),
            child: child,
          );
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 85,
              child: Text(
                '$minutes:$seconds',
                style: Theme.of(
                  context,
                ).textTheme.displayLarge?.copyWith(color: AppColors.white),
              ),
            ),
            Positioned(
              bottom: 4,
              child: Text(
                'Break',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimerPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color backgroundColor;

  _TimerPainter({
    required this.progress,
    required this.color,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 14.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const gapAngle = math.pi / 3;
    const startAngle = math.pi / 2 + gapAngle / 2;
    const sweepAngle = 2 * math.pi - gapAngle;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      backgroundPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _TimerPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

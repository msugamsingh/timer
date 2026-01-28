import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer/timer/bloc/timer_cubit.dart';
import 'package:timer/values/app_colors.dart';
import 'package:timer/values/app_theme.dart';

class BreakEndedCard extends StatelessWidget {
  const BreakEndedCard({super.key});

  @override
  Widget build(BuildContext context) {
    final timerTheme = Theme.of(context).extension<TimerTheme>()!;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      decoration: BoxDecoration(
        gradient: timerTheme.cardGradient,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  color: timerTheme.cardGradient.colors.first,
                  size: 48,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            'Hope you are feeling refreshed and\nready to start working again',
            textAlign: TextAlign.center,
            style: textTheme.titleMedium?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () => context.read<TimerCubit>().resetTimer(),
            child: Text(
              'Reset demo',
              style: textTheme.bodyLarge?.copyWith(
                color: AppColors.white.withValues(alpha: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

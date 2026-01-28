import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer/values/app_colors.dart';
import 'package:timer/values/app_theme.dart';
import 'package:timer/timer/bloc/timer_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const List<int> _durations = [10, 15, 30, 45, 60];

  @override
  Widget build(BuildContext context) {
    final timerTheme = Theme.of(context).extension<TimerTheme>()!;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: textTheme.titleLarge?.copyWith(color: AppColors.slate900),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.slate900),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<TimerCubit, TimerState>(
        builder: (context, state) {
          final currentMinutes = state.defaultDuration ~/ 60;

          return ListView.separated(
            padding: const EdgeInsets.all(24),
            itemCount: _durations.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final minutes = _durations[index];
              final isSelected = minutes == currentMinutes;

              return InkWell(
                onTap: () {
                  context.read<TimerCubit>().setDefaultDuration(minutes * 60);
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? timerTheme.cardGradient.colors.first.withValues(
                            alpha: 0.1,
                          )
                        : AppColors.white,
                    border: Border.all(
                      color: isSelected
                          ? timerTheme.cardGradient.colors.first
                          : AppColors.slate200,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '$minutes min',
                        style: textTheme.titleMedium?.copyWith(
                          color: isSelected
                              ? timerTheme.cardGradient.colors.first
                              : AppColors.slate900,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      if (isSelected)
                        Icon(
                          Icons.check_circle,
                          color: timerTheme.cardGradient.colors.first,
                          size: 24,
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

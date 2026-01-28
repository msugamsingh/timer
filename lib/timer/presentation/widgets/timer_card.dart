import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:timer/timer/bloc/timer_cubit.dart';
import 'package:timer/values/app_colors.dart';
import 'package:timer/values/app_theme.dart';
import 'break_ended_card.dart';
import 'timer_background.dart';
import 'timer_progress_circle.dart';

class TimerCard extends StatelessWidget {
  const TimerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final timerTheme = Theme.of(context).extension<TimerTheme>()!;
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<TimerCubit, TimerState>(
      builder: (context, state) {
        if (state.duration == 0 && state.status == TimerStatus.completed) {
          return const BreakEndedCard();
        }

        final duration = state.duration;
        final minutes = (duration / 60).floor().toString().padLeft(2, '0');
        final seconds = (duration % 60).toString().padLeft(2, '0');

        final now = DateTime.now();
        final endTime = now.add(Duration(seconds: duration));
        final formattedEndTime = DateFormat.jm().format(endTime);

        final progress = state.status == TimerStatus.initial
            ? 1.0
            : (state.initialDuration > 0
                  ? duration / state.initialDuration
                  : 0.0);

        final isInitial = state.status == TimerStatus.initial;

        return TimerBackground(
          child: Column(
            children: [
              Text(
                'We value your hard work!\nTake this time to relax',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 22),
              TimerProgressCircle(
                progress: progress,
                minutes: minutes,
                seconds: seconds,
              ),
              const SizedBox(height: 22),
              Divider(color: AppColors.white.withValues(alpha: 0.2)),
              const SizedBox(height: 4),
              Text(
                'Break ends at $formattedEndTime',
                style: textTheme.titleSmall?.copyWith(color: AppColors.white),
              ),
              const SizedBox(height: 4),

              Divider(color: AppColors.white.withValues(alpha: 0.2)),

              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  if (isInitial) {
                    context.read<TimerCubit>().startTimer();
                  } else {
                    _showEndBreakConfirmation(context, timerTheme);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isInitial
                      ? timerTheme.buttonStart
                      : timerTheme.buttonEnd,
                  foregroundColor: AppColors.white,
                  minimumSize: const Size(double.infinity, 56),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  isInitial ? 'Begin break' : 'End my break',
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showEndBreakConfirmation(BuildContext context, TimerTheme theme) {
    final textTheme = Theme.of(context).textTheme;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      backgroundColor: AppColors.white,
      builder: (bottomSheetContext) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.grey300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Ending break early?',
                style: textTheme.titleLarge?.copyWith(color: theme.textPrimary),
              ),
              const SizedBox(height: 16),
              Text(
                'Are you sure you want to end your break now? Take this time to recharge before your next task.',
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge?.copyWith(
                  color: theme.textPrimary.withValues(alpha: 0.7),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(bottomSheetContext);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.buttonContinue,
                        foregroundColor: AppColors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Continue',
                        style: textTheme.labelLarge?.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        context.read<TimerCubit>().endBreak();
                        Navigator.pop(bottomSheetContext);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: theme.buttonEnd,
                        side: BorderSide(color: theme.buttonEnd),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'End now',
                        style: textTheme.labelLarge?.copyWith(
                          color: theme.buttonEnd,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer/timer/bloc/timer_cubit.dart';
import 'package:timer/values/app_colors.dart';
import 'package:timer/values/app_theme.dart';

enum TimelineStatus { completed, inProgress, notStarted }

class StatusTimeline extends StatelessWidget {
  const StatusTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    final timerTheme = Theme.of(context).extension<TimerTheme>()!;

    return BlocBuilder<TimerCubit, TimerState>(
      builder: (context, state) {
        TimelineStatus lunchStatus;
        if (state.status == TimerStatus.initial) {
          lunchStatus = TimelineStatus.notStarted;
        } else if (state.status == TimerStatus.completed ||
            state.duration == 0) {
          lunchStatus = TimelineStatus.completed;
        } else {
          lunchStatus = TimelineStatus.inProgress;
        }

        // Logic: Bar color belongs to the circle BELOW it.
        // Bar 1 (below Login) color = Lunch status color
        // Bar 2 (below Lunch) color = Logout status color (not started)

        return ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width / 4),
          children: [
            _buildTimelineItem(
              context,
              'Login',
              status: TimelineStatus.completed,
              barColor: _getLineColor(lunchStatus, timerTheme),
              isFirst: true,
            ),
            _buildTimelineItem(
              context,
              'Lunch in Progress',
              status: lunchStatus,
              barColor: _getLineColor(TimelineStatus.notStarted, timerTheme),
            ),
            _buildTimelineItem(
              context,
              'Logout',
              status: TimelineStatus.notStarted,
              isLast: true,
            ),
          ],
        );
      },
    );
  }

  Widget _buildTimelineItem(
    BuildContext context,
    String title, {
    required TimelineStatus status,
    Color? barColor,
    bool isFirst = false,
    bool isLast = false,
  }) {
    final timerTheme = Theme.of(context).extension<TimerTheme>()!;
    final textTheme = Theme.of(context).textTheme;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: _getIconColor(status, timerTheme),
                  shape: BoxShape.circle,
                  border: status == TimelineStatus.notStarted
                      ? Border.all(color: timerTheme.timelineBorder, width: 2)
                      : null,
                ),
                child: status == TimelineStatus.completed
                    ? const Icon(Icons.check, color: AppColors.white, size: 20)
                    : null,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    // Margin removed to attach to circles
                    color: barColor ?? timerTheme.timelineLine,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0, top: 4),
            child: Text(
              title,
              style: textTheme.titleLarge?.copyWith(
                color: status == TimelineStatus.notStarted
                    ? timerTheme.textPrimary.withValues(alpha: 0.5)
                    : timerTheme.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getIconColor(TimelineStatus status, TimerTheme theme) {
    switch (status) {
      case TimelineStatus.completed:
        return theme.statusCompleted;
      case TimelineStatus.inProgress:
        return theme.statusInProgress;
      case TimelineStatus.notStarted:
        return theme.statusNotStarted;
    }
  }

  Color _getLineColor(TimelineStatus status, TimerTheme theme) {
    if (status == TimelineStatus.notStarted) {
      return theme.timelineLine;
    }
    return _getIconColor(status, theme);
  }
}

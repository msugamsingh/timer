part of 'timer_cubit.dart';

enum TimerStatus { initial, running, paused, completed }

class TimerState extends Equatable {
  const TimerState({
    this.duration = 0,
    this.initialDuration = 0,
    this.defaultDuration = 600, // Default 10 minutes
    this.status = TimerStatus.initial,
    this.isBreak = true,
  });

  final int duration;
  final int initialDuration;
  final int defaultDuration;
  final TimerStatus status;
  final bool isBreak;

  TimerState copyWith({
    int? duration,
    int? initialDuration,
    int? defaultDuration,
    TimerStatus? status,
    bool? isBreak,
  }) {
    return TimerState(
      duration: duration ?? this.duration,
      initialDuration: initialDuration ?? this.initialDuration,
      defaultDuration: defaultDuration ?? this.defaultDuration,
      status: status ?? this.status,
      isBreak: isBreak ?? this.isBreak,
    );
  }

  @override
  List<Object> get props => [
    duration,
    initialDuration,
    defaultDuration,
    status,
    isBreak,
  ];
}

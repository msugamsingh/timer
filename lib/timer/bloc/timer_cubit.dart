import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'timer_state.dart';

class TimerCubit extends Cubit<TimerState> {
  TimerCubit()
    : super(
        const TimerState(
          duration: 600,
          initialDuration: 600,
          defaultDuration: 600,
          status: TimerStatus.initial,
        ),
      );

  Timer? _timer;

  void startTimer({int? duration}) {
    // If a duration is provided, use it. Otherwise, resume from current state.
    final startDuration = duration ?? state.duration;

    emit(
      state.copyWith(
        status: TimerStatus.running,
        duration: startDuration,
        initialDuration: state.status == TimerStatus.initial
            ? startDuration
            : state.initialDuration,
      ),
    );

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final newDuration = state.duration - 1;
      if (newDuration >= 0) {
        emit(state.copyWith(duration: newDuration));
      } else {
        _timer?.cancel();
        emit(state.copyWith(status: TimerStatus.completed));
      }
    });
  }

  void pauseTimer() {
    if (state.status == TimerStatus.running) {
      _timer?.cancel();
      emit(state.copyWith(status: TimerStatus.paused));
    }
  }

  void resumeTimer() {
    if (state.status == TimerStatus.paused) {
      startTimer();
    }
  }

  void resetTimer() {
    _timer?.cancel();
    emit(
      TimerState(
        duration: state.defaultDuration,
        initialDuration: state.defaultDuration,
        defaultDuration: state.defaultDuration,
        status: TimerStatus.initial,
        isBreak: true,
      ),
    );
  }

  void endBreak() {
    _timer?.cancel();
    emit(state.copyWith(status: TimerStatus.completed, duration: 0));
  }

  void toggleBreakMode() {
    _timer?.cancel();
    final newIsBreak = !state.isBreak;
    final newDuration = newIsBreak
        ? state.defaultDuration
        : 0;

    emit(
      TimerState(
        isBreak: newIsBreak,
        status: newIsBreak
            ? TimerStatus.initial
            : TimerStatus
                  .completed,
        duration: newDuration,
        initialDuration: newDuration,
        defaultDuration: state.defaultDuration,
      ),
    );

    if (newIsBreak) {
      startTimer();
    }
  }

  void setDefaultDuration(int duration) {
    emit(state.copyWith(defaultDuration: duration));

    if (state.status == TimerStatus.initial) {
      resetTimer();
    } else if (state.status == TimerStatus.running ||
        state.status == TimerStatus.paused) {

      final elapsed = state.initialDuration - state.duration;

      final newDuration = duration - elapsed;

      if (newDuration <= 0) {
        // If the new duration is shorter than what we've already spent, expire immediately
        _timer?.cancel();
        emit(
          state.copyWith(
            initialDuration: duration,
            duration: 0,
            status: TimerStatus.completed,
          ),
        );
      } else {
        // Update the current running timer with new values
        // This preserves the progress relative to time spent
        emit(state.copyWith(initialDuration: duration, duration: newDuration));
      }
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

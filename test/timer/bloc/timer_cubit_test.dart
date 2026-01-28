import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timer/timer/bloc/timer_cubit.dart';

void main() {
  group('TimerCubit', () {
    late TimerCubit timerCubit;

    setUp(() {
      timerCubit = TimerCubit();
    });

    tearDown(() {
      timerCubit.close();
    });

    test('initial state is correct', () {
      expect(
        timerCubit.state,
        const TimerState(
          duration: 600,
          initialDuration: 600,
          defaultDuration: 600,
          status: TimerStatus.initial,
        ),
      );
    });

    blocTest<TimerCubit, TimerState>(
      'emits [running] when startTimer is called',
      build: () => timerCubit,
      act: (cubit) => cubit.startTimer(),
      expect: () => [
        isA<TimerState>()
            .having((s) => s.status, 'status', TimerStatus.running),
      ],
    );

    blocTest<TimerCubit, TimerState>(
      'emits [paused] when pauseTimer is called',
      build: () => timerCubit,
      seed: () => const TimerState(
        duration: 500,
        initialDuration: 600,
        defaultDuration: 600,
        status: TimerStatus.running,
      ),
      act: (cubit) => cubit.pauseTimer(),
      expect: () => [
        const TimerState(
          duration: 500,
          initialDuration: 600,
          defaultDuration: 600,
          status: TimerStatus.paused,
        ),
      ],
    );

    blocTest<TimerCubit, TimerState>(
      'emits [running] when resumeTimer is called',
      build: () => timerCubit,
      seed: () => const TimerState(
        duration: 500,
        initialDuration: 600,
        defaultDuration: 600,
        status: TimerStatus.paused,
      ),
      act: (cubit) => cubit.resumeTimer(),
      expect: () => [
        isA<TimerState>()
            .having((s) => s.status, 'status', TimerStatus.running),
      ],
    );

    blocTest<TimerCubit, TimerState>(
      'emits [initial] when resetTimer is called',
      build: () => timerCubit,
      act: (cubit) => cubit.resetTimer(),
      expect: () => [
        const TimerState(
          duration: 600,
          initialDuration: 600,
          defaultDuration: 600,
          status: TimerStatus.initial,
          isBreak: true,
        ),
      ],
    );

    blocTest<TimerCubit, TimerState>(
      'emits [completed] when endBreak is called',
      build: () => timerCubit,
      act: (cubit) => cubit.endBreak(),
      expect: () => [
        const TimerState(
          duration: 0,
          initialDuration: 600,
          defaultDuration: 600,
          status: TimerStatus.completed,
        ),
      ],
    );

    blocTest<TimerCubit, TimerState>(
      'emits [completed] when setDefaultDuration is shorter than elapsed time',
      build: () => timerCubit,
      seed: () => const TimerState(
        duration: 200, // 400 seconds elapsed (600 - 200)
        initialDuration: 600,
        defaultDuration: 600,
        status: TimerStatus.running,
      ),
      act: (cubit) => cubit.setDefaultDuration(300), // New total 300 < 400 elapsed
      expect: () => [
        const TimerState(
          duration: 200,
          initialDuration: 600,
          defaultDuration: 300,
          status: TimerStatus.running,
        ),
        const TimerState(
          duration: 0,
          initialDuration: 300,
          defaultDuration: 300,
          status: TimerStatus.completed,
        ),
      ],
    );

    blocTest<TimerCubit, TimerState>(
      'updates duration correctly when setDefaultDuration is longer than elapsed time',
      build: () => timerCubit,
      seed: () => const TimerState(
        duration: 500, // 100 seconds elapsed (600 - 500)
        initialDuration: 600,
        defaultDuration: 600,
        status: TimerStatus.running,
      ),
      act: (cubit) => cubit.setDefaultDuration(900), // New total 900
      expect: () => [
        const TimerState(
          duration: 500,
          initialDuration: 600,
          defaultDuration: 900,
          status: TimerStatus.running,
        ),
        const TimerState(
          duration: 800, // 900 - 100 elapsed
          initialDuration: 900,
          defaultDuration: 900,
          status: TimerStatus.running,
        ),
      ],
    );
  });
}
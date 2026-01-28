import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:timer/timer/bloc/timer_cubit.dart';
import 'package:timer/timer/presentation/view/timer_page.dart';
import 'package:timer/values/app_theme.dart';

class MockTimerCubit extends MockCubit<TimerState> implements TimerCubit {}

void main() {
  group('TimerPage', () {
    late TimerCubit timerCubit;

    setUp(() {
      timerCubit = MockTimerCubit();
    });

    Widget buildSubject() {
      return MaterialApp(
        theme: AppTheme.lightTheme,
        home: BlocProvider.value(
          value: timerCubit,
          child: const TimerView(),
        ),
      );
    }

    testWidgets('renders Begin break button initially', (tester) async {
      when(() => timerCubit.state).thenReturn(
        const TimerState(
          duration: 600,
          initialDuration: 600,
          status: TimerStatus.initial,
        ),
      );

      await tester.pumpWidget(buildSubject());

      expect(find.text('Begin break'), findsAtLeastNWidgets(1));
      expect(find.text('End my break'), findsNothing);
    });

    testWidgets('calls startTimer when Begin break is pressed', (tester) async {
      when(() => timerCubit.state).thenReturn(
        const TimerState(
          duration: 600,
          initialDuration: 600,
          status: TimerStatus.initial,
        ),
      );

      await tester.pumpWidget(buildSubject());

      await tester.tap(find.text('Begin break').first);
      verify(() => timerCubit.startTimer()).called(1);
    });

    testWidgets('renders End my break button when running', (tester) async {
      when(() => timerCubit.state).thenReturn(
        const TimerState(
          duration: 599,
          initialDuration: 600,
          status: TimerStatus.running,
        ),
      );

      await tester.pumpWidget(buildSubject());

      expect(find.text('End my break'), findsAtLeastNWidgets(1));
      expect(find.text('Begin break'), findsNothing);
    });

    testWidgets('shows confirmation bottom sheet when End my break is pressed',
        (tester) async {
      when(() => timerCubit.state).thenReturn(
        const TimerState(
          duration: 500,
          initialDuration: 600,
          status: TimerStatus.running,
        ),
      );

      await tester.pumpWidget(buildSubject());

      await tester.tap(find.text('End my break').first);
      await tester.pumpAndSettle();

      expect(find.text('Ending break early?'), findsOneWidget);
      expect(find.text('End now'), findsOneWidget);
      expect(find.text('Continue'), findsOneWidget);
    });

    testWidgets('renders Break Ended card when timer is completed',
        (tester) async {
      when(() => timerCubit.state).thenReturn(
        const TimerState(
          duration: 0,
          initialDuration: 600,
          status: TimerStatus.completed,
        ),
      );

      await tester.pumpWidget(buildSubject());

      expect(
          find.text('Hope you are feeling refreshed and\nready to start working again'),
          findsAtLeastNWidgets(1));
      expect(find.text('Reset demo'), findsAtLeastNWidgets(1));
    });
  });
}

import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

@immutable
class TimerTheme extends ThemeExtension<TimerTheme> {
  const TimerTheme({
    required this.headerBackground,
    required this.cardGradient,
    required this.statusCompleted,
    required this.statusInProgress,
    required this.statusNotStarted,
    required this.timelineBorder,
    required this.timelineLine,
    required this.buttonStart,
    required this.buttonEnd,
    required this.buttonContinue,
    required this.textPrimary,
  });

  final Color headerBackground;
  final LinearGradient cardGradient;
  final Color statusCompleted;
  final Color statusInProgress;
  final Color statusNotStarted;
  final Color timelineBorder;
  final Color timelineLine;
  final Color buttonStart;
  final Color buttonEnd;
  final Color buttonContinue;
  final Color textPrimary;

  @override
  TimerTheme copyWith({
    Color? headerBackground,
    LinearGradient? cardGradient,
    Color? statusCompleted,
    Color? statusInProgress,
    Color? statusNotStarted,
    Color? timelineBorder,
    Color? timelineLine,
    Color? buttonStart,
    Color? buttonEnd,
    Color? buttonContinue,
    Color? textPrimary,
  }) {
    return TimerTheme(
      headerBackground: headerBackground ?? this.headerBackground,
      cardGradient: cardGradient ?? this.cardGradient,
      statusCompleted: statusCompleted ?? this.statusCompleted,
      statusInProgress: statusInProgress ?? this.statusInProgress,
      statusNotStarted: statusNotStarted ?? this.statusNotStarted,
      timelineBorder: timelineBorder ?? this.timelineBorder,
      timelineLine: timelineLine ?? this.timelineLine,
      buttonStart: buttonStart ?? this.buttonStart,
      buttonEnd: buttonEnd ?? this.buttonEnd,
      buttonContinue: buttonContinue ?? this.buttonContinue,
      textPrimary: textPrimary ?? this.textPrimary,
    );
  }

  @override
  TimerTheme lerp(ThemeExtension<TimerTheme>? other, double t) {
    if (other is! TimerTheme) {
      return this;
    }
    return TimerTheme(
      headerBackground: Color.lerp(
        headerBackground,
        other.headerBackground,
        t,
      )!,
      cardGradient: LinearGradient.lerp(cardGradient, other.cardGradient, t)!,
      statusCompleted: Color.lerp(statusCompleted, other.statusCompleted, t)!,
      statusInProgress: Color.lerp(
        statusInProgress,
        other.statusInProgress,
        t,
      )!,
      statusNotStarted: Color.lerp(
        statusNotStarted,
        other.statusNotStarted,
        t,
      )!,
      timelineBorder: Color.lerp(timelineBorder, other.timelineBorder, t)!,
      timelineLine: Color.lerp(timelineLine, other.timelineLine, t)!,
      buttonStart: Color.lerp(buttonStart, other.buttonStart, t)!,
      buttonEnd: Color.lerp(buttonEnd, other.buttonEnd, t)!,
      buttonContinue: Color.lerp(buttonContinue, other.buttonContinue, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
    );
  }
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.white,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.indigo500,
        brightness: Brightness.light,
        surface: AppColors.white,
      ),
      textTheme: AppTextStyles.textTheme,
      extensions: const [
        TimerTheme(
          headerBackground: AppColors.slate900,
          cardGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.indigo500, AppColors.blue500],
          ),
          statusCompleted: AppColors.emerald500,
          statusInProgress: AppColors.amber500,
          statusNotStarted: AppColors.transparent,
          timelineBorder: AppColors.slate300,
          timelineLine: AppColors.slate200,
          buttonStart: AppColors.emerald500,
          buttonEnd: AppColors.red400,
          buttonContinue: AppColors.emeraldLight,
          textPrimary: AppColors.slate900,
        ),
      ],
    );
  }
}

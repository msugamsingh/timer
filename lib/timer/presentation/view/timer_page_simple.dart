import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer/timer/bloc/timer_cubit.dart';
import 'package:timer/values/app_colors.dart';
import 'package:timer/timer/presentation/widgets/header_background.dart';
import 'package:timer/timer/presentation/widgets/status_timeline.dart';
import 'package:timer/timer/presentation/widgets/timer_card.dart';
import 'package:timer/timer/presentation/widgets/top_bar.dart';


/// This is the simple version of the timer app and uses separate instance of the timer cubit.
/// [TimerPage] has the custom-scroll and snap version of the timer app.

class TimerPageSimple extends StatelessWidget {
  const TimerPageSimple({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerCubit(),
      child: const TimerViewSimple(),
    );
  }
}

class TimerViewSimple extends StatelessWidget {
  const TimerViewSimple({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            const HeaderBackground(),

            Column(
              children: [
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        const TopBar(),
                        const SizedBox(height: 30),
                        Text(
                          'Hi, Guest!',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: AppColors.white.withValues(alpha: 0.7),
                              ),
                        ),
                        Text(
                          'You are on break!',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(color: AppColors.white),
                        ),
                        const SizedBox(height: 30),
                        const TimerCard(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const StatusTimeline(),
                const SizedBox(height: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

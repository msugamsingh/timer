import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer/timer/bloc/timer_cubit.dart';
import 'package:timer/timer/presentation/widgets/header_background.dart';
import 'package:timer/timer/presentation/widgets/status_timeline.dart';
import 'package:timer/timer/presentation/widgets/timer_card.dart';
import 'package:timer/values/app_colors.dart';
import 'package:timer/values/app_theme.dart';

import 'settings_page.dart';
import 'timer_page_simple.dart';


/// This is the custom-scroll and snap version of the timer app.
/// [TimerPageSimple] has the simple scrolling and has its own cubit instance.
class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => TimerCubit(), child: const TimerView());
  }
}

class TimerView extends StatefulWidget {
  const TimerView({super.key});

  @override
  State<TimerView> createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {
  // Constants
  static const double _expandedAppBarHeight = 220.0;
  static const double _overlap = 60.0;
  static const double _snapThreshold = 10.0;

  final ScrollController _scrollController = ScrollController();
  double _dragStartOffset = 0;
  bool _showOverlapCard = true;

  late final Widget _timerCard;

  @override
  void initState() {
    super.initState();
    _timerCard = const TimerCard();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleDirectionalSnap(ScrollNotification notification) {
    final collapsedTarget = _expandedAppBarHeight - kToolbarHeight;

    if (notification is ScrollStartNotification) {
      _dragStartOffset = _scrollController.offset;
    }

    if (notification is ScrollUpdateNotification) {
      final currentOffset = _scrollController.offset;
      final delta = currentOffset - _dragStartOffset;

      if (delta > _snapThreshold && _showOverlapCard) {
        _snapTo(collapsedTarget, false);
      } else if (delta < -_snapThreshold &&
          !_showOverlapCard &&
          currentOffset < collapsedTarget) {
        _snapTo(0, true);
      }
    }
  }

  void _snapTo(double offset, bool showFloating) {
    if (_showOverlapCard == showFloating &&
        _scrollController.offset == offset) {
      return;
    }

    setState(() => _showOverlapCard = showFloating);
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final timerTheme = Theme.of(context).extension<TimerTheme>()!;
    final topPadding = MediaQuery.of(context).padding.top;
    final overlapTop = topPadding + _expandedAppBarHeight - _overlap;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              _handleDirectionalSnap(notification);
              return false;
            },
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                _buildSliverAppBar(timerTheme),
                _buildInlineTimerCard(),
                const SliverToBoxAdapter(child: StatusTimeline()),
                const SliverToBoxAdapter(child: SizedBox(height: 50)),
              ],
            ),
          ),
          _buildFloatingTimerCard(overlapTop),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(TimerTheme theme) {
    final textTheme = Theme.of(context).textTheme;

    return SliverAppBar(
      expandedHeight: _expandedAppBarHeight,
      pinned: true,
      stretch: true,
      backgroundColor: theme.headerBackground,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TimerPageSimple()),
        ),
        icon: const Icon(Icons.menu, color: AppColors.white, size: 28),
      ),
      actions: [
        _HelpButton(textTheme: textTheme),
        const SizedBox(width: 12),
        const _SettingsButton(),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [const HeaderBackground(), _buildGreetingText(textTheme)],
        ),
      ),
    );
  }

  Widget _buildGreetingText(TextTheme textTheme) {
    return Positioned(
      bottom: 80,
      left: 24,
      right: 24,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _showOverlapCard
            ? Column(
                key: const ValueKey('expanded_text'),
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Hi, Guest!',
                    style: textTheme.bodyLarge?.copyWith(
                      color: AppColors.white.withValues(alpha: 0.7),
                    ),
                  ),
                  Text(
                    'You are on break!',
                    style: textTheme.headlineMedium?.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink(key: ValueKey('collapsed_space')),
      ),
    );
  }

  Widget _buildInlineTimerCard() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Transform.translate(
            offset: Offset(0, _showOverlapCard ? -_overlap + 8 : 0),
            child: Opacity(
              opacity: _showOverlapCard ? 0 : 1,
              child: Padding(
                padding: _showOverlapCard
                    ? EdgeInsets.zero
                    : const EdgeInsets.all(16.0),
                child: _timerCard,
              ),
            ),
          ),
          SizedBox(height: _showOverlapCard ? 10 : 50),
        ],
      ),
    );
  }

  Widget _buildFloatingTimerCard(double topOffset) {
    return Positioned(
      top: topOffset,
      left: 16,
      right: 16,
      child: IgnorePointer(
        ignoring: true,
        child: ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: _showOverlapCard ? 1.0 : 0.0,
            child: _timerCard,
          ),
        ),
      ),
    );
  }
}

// --- Internal Widgets ---

class _HelpButton extends StatelessWidget {
  final TextTheme textTheme;

  const _HelpButton({required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.white.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.call, size: 18, color: AppColors.white),
          const SizedBox(width: 8),
          Text(
            'Help',
            style: textTheme.titleSmall?.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}

class _SettingsButton extends StatelessWidget {
  const _SettingsButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider.value(
              value: context.read<TimerCubit>(),
              child: const SettingsPage(),
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 8, bottom: 8, right: 24),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.white.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.settings_outlined,
          color: AppColors.white,
          size: 20,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timer/timer/presentation/view/timer_page.dart';
import 'values/app_theme.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const TimerApp());
}

class TimerApp extends StatelessWidget {
  const TimerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const TimerPage(),
    );
  }
}

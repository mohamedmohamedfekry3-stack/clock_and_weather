import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/core/constants/app_strings.dart';
import 'package:flutter_analog_clock/core/networking/get_weather.dart';
import 'package:flutter_analog_clock/core/theme/app_theme.dart';
import 'package:flutter_analog_clock/core/theme/theme_controller.dart';
import 'package:flutter_analog_clock/features/clock/presentation/screens/clock_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ThemeController.instance,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appTitle,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeController.instance.themeMode,
          home: const ClockScreen(),
        );
      },
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/features/clock/presentation/widgets/analog_clock.dart';
import 'package:flutter_analog_clock/features/clock/presentation/widgets/digital_clock_display.dart';
import 'package:flutter_analog_clock/features/clock/presentation/widgets/greeting_header.dart';
import 'package:flutter_analog_clock/features/clock/presentation/widgets/info_cards.dart';
import 'package:flutter_analog_clock/features/clock/presentation/widgets/inspiration_footer.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  late DateTime _currentTime;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {
          _currentTime = DateTime.now();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final clockSize = (constraints.maxWidth * 0.72).clamp(220.0, 320.0);

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GreetingHeader(dateTime: _currentTime),

                    const SizedBox(height: 28),

                    AnalogClock(dateTime: _currentTime, size: clockSize),

                    const SizedBox(height: 20),

                    DigitalClockDisplay(dateTime: _currentTime),

                    const SizedBox(height: 28),

                    const InfoCards(),

                    const SizedBox(height: 32),
                    const InspirationFooter(),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

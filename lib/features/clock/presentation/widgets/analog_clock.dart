import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/features/clock/presentation/widgets/clock_painter.dart';

class AnalogClock extends StatelessWidget {
  final DateTime dateTime;
  final double size;

  const AnalogClock({super.key, required this.dateTime, this.size = 280});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? const Color(0xFF00E5FF).withAlpha(20)
                  : const Color(0xFF0284C7).withAlpha(25),
              blurRadius: 30,
              spreadRadius: 2,
            ),
          ],
        ),
        child: CustomPaint(
          size: Size(size, size),
          painter: ClockPainter(dateTime: dateTime, isDark: isDark),
        ),
      ),
    );
  }
}

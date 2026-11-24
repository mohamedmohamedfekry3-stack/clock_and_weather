import 'dart:math';
import 'package:flutter/material.dart';

class ClockPainter extends CustomPainter {
  final DateTime dateTime;
  final bool isDark;

  final Color faceColor;
  final Color hourTickColor;
  final Color minuteTickColor;
  final Color hourHandColor;
  final Color minuteHandColor;
  final Color secondHandColor;
  final Color centerCapColor;
  final Color numberColor;

  ClockPainter({
    required this.dateTime,
    this.isDark = true,
    Color? faceColor,
    Color? hourTickColor,
    Color? minuteTickColor,
    Color? hourHandColor,
    Color? minuteHandColor,
    Color? secondHandColor,
    Color? centerCapColor,
    Color? numberColor,
  }) : faceColor =
           faceColor ??
           (isDark ? const Color(0xFF141A29) : const Color(0xFFF1F5F9)),
       hourTickColor =
           hourTickColor ??
           (isDark ? const Color(0xFF00E5FF) : const Color(0xFF0284C7)),
       minuteTickColor =
           minuteTickColor ??
           (isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1)),
       hourHandColor =
           hourHandColor ??
           (isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A)),
       minuteHandColor =
           minuteHandColor ??
           (isDark ? const Color(0xFF818CF8) : const Color(0xFF6366F1)),
       secondHandColor =
           secondHandColor ??
           (isDark ? const Color(0xFFFF4081) : const Color(0xFFE11D48)),
       centerCapColor =
           centerCapColor ??
           (isDark ? const Color(0xFF00E5FF) : const Color(0xFF0284C7)),
       numberColor =
           numberColor ??
           (isDark ? const Color(0xFFE2E8F0) : const Color(0xFF1E293B));

  static const List<String> _digits = [
    '12',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = min(size.width, size.height) / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double angle = (2 * pi) / 60;

    final Paint faceFillPaint = Paint()
      ..color = faceColor
      ..style = PaintingStyle.fill;

    final Paint outerGlowPaint = Paint()
      ..color = (isDark ? const Color(0xFF00E5FF) : const Color(0xFF0284C7))
          .withAlpha(isDark ? 40 : 25)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);

    final Paint faceBorderPaint = Paint()
      ..color = (isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    canvas.drawCircle(center, radius - 4, outerGlowPaint);
    canvas.drawCircle(center, radius - 4, faceFillPaint);
    canvas.drawCircle(center, radius - 4, faceBorderPaint);

    canvas.save();
    canvas.translate(center.dx, center.dy);

    final Paint hourTickPaint = Paint()
      ..color = hourTickColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.032
      ..strokeCap = StrokeCap.round;

    final Paint minuteTickPaint = Paint()
      ..color = minuteTickColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.015
      ..strokeCap = StrokeCap.round;

    for (var i = 0; i < 60; i++) {
      final bool isHour = i % 5 == 0;

      if (isHour) {
        canvas.drawLine(
          Offset(0, -radius * 0.94),
          Offset(0, -(radius - radius * 0.16)),
          hourTickPaint,
        );

        final textSpan = TextSpan(
          text: _digits[i ~/ 5],
          style: TextStyle(
            color: numberColor,
            fontSize: radius * 0.13,
            fontWeight: FontWeight.bold,
            letterSpacing: 0,
          ),
        );

        final textPainter = TextPainter(
          text: textSpan,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );

        textPainter.layout();

        canvas.save();
        canvas.translate(0, -(radius - radius * 0.28));
        canvas.rotate(-angle * i);
        textPainter.paint(
          canvas,
          Offset(-textPainter.width / 2, -textPainter.height / 2),
        );
        canvas.restore();
      } else {
        canvas.drawLine(
          Offset(0, -radius * 0.94),
          Offset(0, -(radius - radius * 0.08)),
          minuteTickPaint,
        );
      }

      canvas.rotate(angle);
    }
    canvas.restore();

    canvas.save();
    canvas.translate(center.dx, center.dy);

    final double hourAngle =
        ((dateTime.hour % 12) + dateTime.minute / 60.0) * (2 * pi / 12);
    final Paint hourPaint = Paint()
      ..color = hourHandColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.045
      ..strokeCap = StrokeCap.round;

    canvas.save();
    canvas.rotate(hourAngle);
    canvas.drawLine(
      Offset(0, radius * 0.08),
      Offset(0, -radius * 0.52),
      hourPaint,
    );
    canvas.restore();

    final double minuteAngle =
        (dateTime.minute + dateTime.second / 60.0) * (2 * pi / 60);
    final Paint minutePaint = Paint()
      ..color = minuteHandColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.028
      ..strokeCap = StrokeCap.round;

    canvas.save();
    canvas.rotate(minuteAngle);
    canvas.drawLine(
      Offset(0, radius * 0.08),
      Offset(0, -radius * 0.72),
      minutePaint,
    );
    canvas.restore();

    final double secondAngle = dateTime.second * (2 * pi / 60);
    final Paint secondPaint = Paint()
      ..color = secondHandColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.012
      ..strokeCap = StrokeCap.round;

    canvas.save();
    canvas.rotate(secondAngle);
    canvas.drawLine(
      Offset(0, radius * 0.15),
      Offset(0, -radius * 0.78),
      secondPaint,
    );

    final Paint tipAccentPaint = Paint()
      ..color = secondHandColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(0, -radius * 0.60),
      radius * 0.025,
      tipAccentPaint,
    );
    canvas.restore();

    final Paint centerOuterPaint = Paint()
      ..color = centerCapColor
      ..style = PaintingStyle.fill;
    final Paint centerInnerPaint = Paint()
      ..color = secondHandColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset.zero, radius * 0.065, centerOuterPaint);
    canvas.drawCircle(Offset.zero, radius * 0.03, centerInnerPaint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(ClockPainter oldDelegate) {
    return oldDelegate.dateTime != dateTime || oldDelegate.isDark != isDark;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/core/constants/app_strings.dart';

class InspirationFooter extends StatelessWidget {
  const InspirationFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final primaryAccent = theme.colorScheme.primary;
    final textMuted = isDark
        ? const Color(0xFF94A3B8)
        : const Color(0xFF64748B);

    return Column(
      children: [
        Text(
          AppStrings.quoteHeader,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            letterSpacing: 2.5,
            fontWeight: FontWeight.w700,
            color: textMuted,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          AppStrings.quoteBody,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w600,
            color: isDark ? const Color(0xFFF1F5F9) : const Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 36,
              height: 1.5,
              color: primaryAccent.withAlpha(90),
            ),
            const SizedBox(width: 10),
            Icon(
              Icons.access_time_filled_rounded,
              color: primaryAccent,
              size: 16,
            ),
            const SizedBox(width: 10),
            Container(
              width: 36,
              height: 1.5,
              color: primaryAccent.withAlpha(90),
            ),
          ],
        ),
      ],
    );
  }
}

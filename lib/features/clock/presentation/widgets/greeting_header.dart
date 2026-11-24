import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/core/constants/app_strings.dart';
import 'package:flutter_analog_clock/core/theme/theme_controller.dart';
import 'package:flutter_analog_clock/core/utils/date_time_utils.dart';

class GreetingHeader extends StatelessWidget {
  final DateTime dateTime;

  const GreetingHeader({super.key, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withAlpha(25),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: theme.colorScheme.primary.withAlpha(60),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.circle, size: 8, color: theme.colorScheme.primary),
                  const SizedBox(width: 8),
                  Text(
                    AppStrings.appTitle,
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 3,
                      fontWeight: FontWeight.w800,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),

            IconButton(
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, anim) =>
                    RotationTransition(turns: anim, child: child),
                child: Icon(
                  isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                  key: ValueKey(isDark),
                  color: theme.colorScheme.primary,
                ),
              ),
              tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
              onPressed: () {
                ThemeController.instance.toggleTheme();
              },
            ),
          ],
        ),

        const SizedBox(height: 16),

        Text(
          DateTimeUtils.getGreeting(dateTime),
          style: theme.textTheme.headlineLarge,
        ),

        const SizedBox(height: 6),

        Text(
          DateTimeUtils.formatDate(dateTime),
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
          ),
        ),

        const SizedBox(height: 8),

        Text(
          DateTimeUtils.getGreetingSubtitle(dateTime),
          style: TextStyle(
            fontSize: 13,
            letterSpacing: 2,
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}

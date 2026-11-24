import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/core/constants/app_strings.dart';

class InfoCards extends StatefulWidget {
  const InfoCards({super.key});

  @override
  State<InfoCards> createState() => _InfoCardsState();
}

class _InfoCardsState extends State<InfoCards> {
  late final Future<String> _tempFuture;
  late final Future<String> windAndPresure;

  @override
  void initState() {
    super.initState();
    _tempFuture = AppStrings.getTemprature();
    windAndPresure = AppStrings.getPreasureAndWind();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final cardBg = isDark ? const Color(0xFF141A29) : const Color(0xFFFFFFFF);
    final borderColor = isDark
        ? const Color(0xFF26334D)
        : const Color(0xFFE2E8F0);
    final textMuted = isDark
        ? const Color(0xFF94A3B8)
        : const Color(0xFF64748B);

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [const Color(0xFF1E2638), const Color(0xFF141A29)]
                  : [const Color(0xFFFFFFFF), const Color(0xFFF8FAFC)],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(isDark ? 25 : 8),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.wb_sunny_outlined,
                  size: 28,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.weatherLabel,
                      style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.bold,
                        color: textMuted,
                      ),
                    ),
                    const SizedBox(height: 4),
                    FutureBuilder<String>(
                      future: _tempFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text(
                            '--°C  •  Partly Cloudy',
                            style: theme.textTheme.titleMedium,
                          );
                        }
                        if (snapshot.hasError || !snapshot.hasData) {
                          return Text(
                            'N/A  •  Partly Cloudy',
                            style: theme.textTheme.titleMedium,
                          );
                        }
                        return Text(
                          AppStrings.formatWeatherValue(snapshot.data!),
                          style: theme.textTheme.titleMedium,
                        );
                      },
                    ),
                    const SizedBox(height: 2),
                    FutureBuilder<String>(
                      future: windAndPresure,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text(
                            'Preasure --  |  Wind -- km/h',
                            style: TextStyle(fontSize: 11, color: textMuted),
                          );
                        }
                        if (snapshot.hasError || !snapshot.hasData) {
                          return Text(
                            'Preasure N/A  |  Wind N/A km/h',
                            style: TextStyle(fontSize: 11, color: textMuted),
                          );
                        }
                        return Text(
                          snapshot.data!,
                          style: TextStyle(fontSize: 11, color: textMuted),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: borderColor, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(isDark ? 20 : 6),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color:
                            (isDark
                                    ? const Color(0xFFFF4081)
                                    : const Color(0xFFE11D48))
                                .withAlpha(25),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.alarm_rounded,
                        color: isDark
                            ? const Color(0xFFFF4081)
                            : const Color(0xFFE11D48),
                        size: 20,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      AppStrings.nextAlarmLabel,
                      style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                        color: textMuted,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppStrings.nextAlarmTime,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      AppStrings.nextAlarmSub,
                      style: TextStyle(fontSize: 11, color: textMuted),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 14),

            // Focus Session Card
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardBg,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: borderColor, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(isDark ? 20 : 6),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondary.withAlpha(25),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.timer_outlined,
                        color: theme.colorScheme.secondary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      AppStrings.focusSessionLabel,
                      style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                        color: textMuted,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppStrings.focusSessionTime,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      AppStrings.focusSessionSub,
                      style: TextStyle(fontSize: 11, color: textMuted),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

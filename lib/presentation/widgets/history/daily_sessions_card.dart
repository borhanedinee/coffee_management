import 'package:coffee_shop_managementt/core/services/date_formats.dart';
import 'package:coffee_shop_managementt/data/models/daily_sessions_model.dart';
import 'package:coffee_shop_managementt/presentation/widgets/history/session_card.dart';
import 'package:coffee_shop_managementt/presentation/widgets/history/session_placeholder.dart';
import 'package:flutter/material.dart';

class DailySessionsCard extends StatelessWidget {
  final DailySessionsModel dailySessions;

  const DailySessionsCard({
    super.key,
    required this.dailySessions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 10,
            children: [
              Icon(
                Icons.calendar_today,
                color: Colors.black54,
                size: 20,
              ),
              Text(
                formatDateWithOrdinal(dailySessions.date),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        dailySessions.morningSession == null
            ? SessionPlaceholder(period: 'morning')
            : SessionCard(
                session: dailySessions.morningSession!,
                onDelete: () {},
              ),
        dailySessions.eveningSession == null
            ? SessionPlaceholder(period: 'evening')
            : SessionCard(
                session: dailySessions.eveningSession!,
                onDelete: () {},
              ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class SessionPlaceholder extends StatelessWidget {
  final String period; // "morning" or "evening"

  const SessionPlaceholder({
    super.key,
    required this.period,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(
          vertical: 5, horizontal: 14), // Match SessionCard margin
      child: Padding(
        padding: const EdgeInsets.all(12), // Match SessionCard padding
        child: Row(
          children: [
            // Icon to indicate "empty"
            Icon(
              period == 'morning' ? Icons.wb_sunny : Icons.nightlight_round,
              color: Colors.grey[600],
              size: 30,
            ),
            const SizedBox(width: 16),
            // Message
            Expanded(
              child: Text(
                'No $period session for this day',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:coffee_shop_managementt/data/models/session_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SessionCard extends StatelessWidget {
  final SessionModel session;
  final VoidCallback onDelete;

  const SessionCard({
    super.key,
    required this.session,
    required this.onDelete,
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
      margin: const EdgeInsets.only(
        top: 5,
        left: 14,
        right: 14,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: 5,
                  children: [
                    Icon(
                      session.period == SessionPeriod.morning
                          ? Icons.sunny
                          : Icons.nightlight_sharp,
                      color: Colors.black,
                      size: 20,
                    ),
                    Text(
                      '${session.period.toString().split('.').last.capitalizeFirst} Session',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF212121),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    gradient: session.status == SessionStatus.suspicious
                        ? LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.red,
                              Colors.red.shade200,
                            ],
                          )
                        : LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.green,
                              Colors.green.shade200,
                            ],
                          ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    session.status.toString().split('.').last.capitalizeFirst!,
                  ),
                ),
              ],
            ),
            _buildRow(
                'Reported Price :', '${session.priceInCaisse.toInt()} DA'),
            _buildRow('Calculated Price :',
                '${session.priceCalculatedByApp.toInt()} DA'),
            session.status == SessionStatus.suspicious
                ? _buildRow('Difference :',
                    '${session.priceCalculatedByApp.toInt() - session.priceInCaisse.toInt()} DA')
                : const SizedBox(),
            _buildRow(
                'Tolerance Value :', '${session.toleranceValue.toInt()} DA'),
          ],
        ),
      ),
    );
  }

  Padding _buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
          Text(
            value,
            style: const TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

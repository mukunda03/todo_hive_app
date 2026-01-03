import 'package:flutter/material.dart';

Widget buildEmptyState(String? filterList) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // --- A very clean, minimalist icon with a subtle glow ---
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.02),
            border: Border.all(color: Colors.white.withOpacity(0.05)),
          ),
          child: Icon(
            Icons.checklist_rounded,
            size: 40,
            color: Colors.white.withOpacity(0.2),
          ),
        ),
        const SizedBox(height: 24),

        // --- Normal, easy-to-read text ---
        Text(
          'Your ${filterList ?? ""} List is empty',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Tap the + button to add a new task.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 14),
        ),
      ],
    ),
  );
}

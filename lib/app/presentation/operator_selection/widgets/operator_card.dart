import 'package:flutter/material.dart';

class OperatorCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;

  const OperatorCard({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.iconColor = Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          child: Row(
            children: [
              const Icon(
                Icons.stars,
                size: 24,
                color: Colors.black54,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Text(
                '⌘C',
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.play_arrow_rounded,
                size: 16,
                color: Colors.black26,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

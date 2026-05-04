import 'package:flutter/material.dart';
import 'package:projeto_integrador_03/core/responsive_context.dart';

class OperatorCard extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const OperatorCard({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final fontSize = context.responsiveValue<double>(
      mobile: 18.0,
      tablet: 24.0,
    );

    final iconSize = context.responsiveValue<double>(
      mobile: 24.0,
      tablet: 32.0,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: context.responsiveValue<double>(
              mobile: 10.0,
              tablet: 16.0,
            ),
            horizontal: 16.0,
          ),
          child: Row(
            children: [
              Icon(Icons.stars, size: iconSize, color: Colors.black54),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                '⌘C',
                style: TextStyle(
                  color: Colors.black26,
                  fontSize: context.responsiveValue<double>(
                    mobile: 12.0,
                    tablet: 16.0,
                  ),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.play_arrow_rounded,
                size: iconSize * 0.7,
                color: Colors.black26,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

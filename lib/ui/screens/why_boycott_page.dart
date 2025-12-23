import 'package:flutter/material.dart';

class WhyBoycottPage extends StatelessWidget {
  const WhyBoycottPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Text(
          'Why Boycott? This page will explain the mission and reasons.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

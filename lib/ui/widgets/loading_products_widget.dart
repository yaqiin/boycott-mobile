import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LoadingProductWidget extends StatelessWidget {
  const LoadingProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headerColor = theme.brightness == Brightness.light
        ? theme.colorScheme.primary.withValues(alpha: 0.08)
        : Colors.white.withValues(alpha: 0.04);
    return Skeletonizer(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    color: headerColor,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Loading Company Name"),
                              SizedBox(height: 12),
                              Chip(label: Text("Loading Category")),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(width: 28, height: 18),
                            SizedBox(height: 6),
                            Text("Loading Country"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(height: 1, thickness: 1, color: theme.dividerColor),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 14),
                    child: Text('Alternatives:'),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      children: [
                        for (int i = 0; i < 2; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: SizedBox(width: 34, height: 34),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text("Loading Alternative Name"),
                                ),
                                SizedBox(width: 28, height: 18),
                                SizedBox(width: 8),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 140,
                                  ),
                                  child: Text("Loading Alternative Link"),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

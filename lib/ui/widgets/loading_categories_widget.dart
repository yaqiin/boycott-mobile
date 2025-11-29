import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LoadingCategoriesWidget extends StatelessWidget {
  const LoadingCategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: SizedBox(
        height: 56,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          separatorBuilder: (_, _) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            return FilterChip(
              label: Text("Loading Category"),
              onSelected: (bool value) {},
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../features/why/cubit/why_cubit.dart';
import '../../features/why/data/models/why_reason.dart';

class WhyBoycottPage extends StatelessWidget {
  const WhyBoycottPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WhyCubit, WhyState>(
      builder: (context, state) {
        if (state is WhyLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is WhyFailure) {
          return _ErrorView(
            message: state.message,
            onRetry: () => context.read<WhyCubit>().loadReasons(),
          );
        }

        if (state is WhyLoaded) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth >= 720 ? 2 : 1;
              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          'Why Boycott?',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: constraints.maxWidth >= 720
                            ? 1.9
                            : 1.4,
                      ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final reason = state.reasons[index];
                        return _ReasonCard(reason: reason);
                      }, childCount: state.reasons.length),
                    ),
                  ),
                ],
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}

class _ReasonCard extends StatelessWidget {
  const _ReasonCard({required this.reason});

  final WhyReason reason;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconData = _iconFromString(reason.icon);
    final borderColor = theme.dividerColor.withValues(alpha: 0.25);
    final cardColor = theme.cardTheme.color ?? theme.colorScheme.surface;

    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: borderColor),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    iconData,
                    color: theme.colorScheme.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    reason.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(reason.description, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }

  IconData _iconFromString(String name) {
    switch (name.toLowerCase()) {
      case 'crosshair':
        return LucideIcons.crosshair;
      case 'fence':
        return LucideIcons.fence;
      case 'network':
        return LucideIcons.network;
      case 'hearthandshake':
      case 'heart_handshake':
        return LucideIcons.handHeart;
      case 'users':
        return LucideIcons.users;
      case 'scale':
        return LucideIcons.scale;
      default:
        return LucideIcons.info;
    }
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(message, textAlign: TextAlign.center),
          ),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}

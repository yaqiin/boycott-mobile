import 'package:flutter/material.dart';
import 'package:flutter_easy_translate/flutter_easy_translate.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final subtitleStyle = theme.textTheme.bodyMedium?.copyWith(
      color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.8),
    );

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            translate('settings.title'),
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(translate('settings.subtitle'), style: subtitleStyle),
          const SizedBox(height: 16),
          _SettingsCard(
            icon: LucideIcons.sunMoon,
            title: translate('settings.appearance'),
            subtitle: translate('settings.appearanceSubtitle'),
            child: Row(
              children: const [
                _ChoiceChip(label: 'settings.theme.light', selected: false),
                SizedBox(width: 10),
                _ChoiceChip(label: 'settings.theme.dark', selected: true),
                SizedBox(width: 10),
                _ChoiceChip(label: 'settings.theme.system', selected: false),
              ],
            ),
          ),
          _SettingsCard(
            icon: LucideIcons.languages,
            title: translate('settings.language'),
            subtitle: translate('settings.languageSubtitle'),
            child: Wrap(
              spacing: 10,
              runSpacing: 8,
              children: const [
                _ChoiceChip(label: 'languages.en', selected: true),
                _ChoiceChip(label: 'languages.ar', selected: false),
                _ChoiceChip(label: 'languages.fr', selected: false),
                _ChoiceChip(label: 'languages.es', selected: false),
                _ChoiceChip(label: 'languages.id', selected: false),
                _ChoiceChip(label: 'languages.tr', selected: false),
                _ChoiceChip(label: 'languages.ur', selected: false),
                _ChoiceChip(label: 'languages.bn', selected: false),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = theme.dividerColor.withValues(alpha: 0.25);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: theme.colorScheme.primary, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.textTheme.bodySmall?.color?.withValues(
                            alpha: 0.8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    );
  }
}

class _ChoiceChip extends StatelessWidget {
  const _ChoiceChip({required this.label, required this.selected});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: selected
            ? theme.colorScheme.primary.withValues(alpha: 0.12)
            : theme.cardColor.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: selected
              ? theme.colorScheme.primary
              : theme.dividerColor.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        translate(label),
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: selected
              ? theme.colorScheme.primary
              : theme.colorScheme.onSurface,
        ),
      ),
    );
  }
}

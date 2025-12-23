import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easy_translate/flutter_easy_translate.dart';

import '../../models/boycott_company.dart';

class BoycottProductCard extends StatelessWidget {
  const BoycottProductCard({super.key, required this.company});

  final BoycottCompany company;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headerColor = theme.brightness == Brightness.light
        ? theme.colorScheme.surfaceContainerHighest
        : Colors.white.withValues(alpha: 0.04);
    final alternatives = company.alternatives;

    return Card(
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
                      Text(
                        company.name,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Chip(
                        label: Text(company.category),
                        elevation: 0,
                        backgroundColor: theme.chipTheme.backgroundColor,
                        labelStyle: theme.chipTheme.labelStyle,
                        padding: theme.chipTheme.padding,
                        shape: theme.chipTheme.shape,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildFlag(company.countryCode),
                    const SizedBox(height: 6),
                    Text(
                      company.country,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 1, thickness: 1, color: theme.dividerColor),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 14),
            child: Text(
              translate('products.alternatives'),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          if (alternatives == null || alternatives.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text(
                translate('products.noAlternatives'),
                style: theme.textTheme.bodyMedium,
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  for (final alt in alternatives)
                    _AlternativeRow(alternative: alt),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFlag(String code) {
    final normalized = code.trim();
    if (normalized.length != 2) {
      return const SizedBox(width: 28, height: 18);
    }

    return CountryFlag.fromCountryCode(
      normalized.toUpperCase(),
      theme: const ImageTheme(
        width: 28,
        height: 18,
        shape: RoundedRectangle(4),
      ),
    );
  }
}

class _AlternativeRow extends StatelessWidget {
  const _AlternativeRow({required this.alternative});

  final BoycottAlternative alternative;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final flag = _flagOrPlaceholder(alternative.countryCode);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              _faviconUrl(alternative.link),
              width: 34,
              height: 34,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 34,
                  height: 34,
                  alignment: Alignment.center,
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  child: Icon(Icons.public, color: theme.colorScheme.primary),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              alternative.name,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          flag,
          const SizedBox(width: 8),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 140),
            child: Text(
              alternative.country,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _flagOrPlaceholder(String code) {
    final normalized = code.trim();
    if (normalized.length != 2) {
      return SizedBox(
        width: 28,
        height: 18,
        child: normalized == "OSS" ? Icon(Icons.code) : null,
      );
    }

    return CountryFlag.fromCountryCode(
      normalized.toUpperCase(),
      theme: const ImageTheme(
        width: 28,
        height: 18,
        shape: RoundedRectangle(4),
      ),
    );
  }

  static String _faviconUrl(String link) {
    return 'https://www.google.com/s2/favicons?domain=$link';
  }
}

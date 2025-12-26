import 'package:flutter/material.dart';
import 'package:flutter_easy_translate/flutter_easy_translate.dart';

class ProductSearchWidget extends StatelessWidget {
  const ProductSearchWidget({
    super.key,
    required this.onSearch,
    this.onTap,
    this.readOnly = false,
    this.onTapOutside,
    this.autoFocus = false,
  });

  final ValueChanged<String> onSearch;
  final VoidCallback? onTap;
  final bool readOnly;
  final bool autoFocus;
  final void Function(PointerDownEvent)? onTapOutside;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        readOnly: readOnly,
        onChanged: onSearch,
        onSubmitted: onSearch,
        onTap: onTap,
        autofocus: autoFocus,
        decoration: InputDecoration(
          hintText: translate('products.searchPlaceholder'),
          prefixIcon: Icon(
            Icons.search,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          filled: true,
          fillColor: theme.brightness == Brightness.light
              ? theme.colorScheme.surface
              : theme.colorScheme.surfaceContainerHighest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: theme.colorScheme.outlineVariant),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: theme.colorScheme.outlineVariant),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: readOnly ? Colors.transparent : theme.colorScheme.primary,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}

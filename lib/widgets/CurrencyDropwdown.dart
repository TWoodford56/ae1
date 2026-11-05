import 'package:ae1/Currency/currency.dart';
import 'package:flutter/material.dart';

/// A dropdown for choosing a currency
class CurrencyDropdown extends StatelessWidget {
  // Creates a dropdown showing currency codes of provided currencies
  const CurrencyDropdown({
    super.key,
    required this.value,
    required this.onCurrencyChanged,
  });

  // The currently selected currency.
  final Currency value;

  // Called with the newly chosen currency.
  final ValueChanged<Currency> onCurrencyChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: value.name,
        borderRadius: BorderRadius.circular(12),
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.onSurface,
        ),
        items: supportedCurrencies.map((Currency currency) {
          return DropdownMenuItem<String>(
            value: currency.name,
            child: Text('${currency.sign}  ${currency.name}'),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue == null) return;
          onCurrencyChanged(
            supportedCurrencies.firstWhere((c) => c.name == newValue),
          );
        },
      ),
    );
  }
}

import 'package:ae1/Currency/currency.dart';
import 'package:flutter/material.dart';

class CurrencyDropdown extends StatefulWidget {
  const CurrencyDropdown({super.key, required this.onCurrencyChanged});

  final Function(Currency) onCurrencyChanged;

  @override
  State<CurrencyDropdown> createState() => _CurrencyDropdownState();
}

class _CurrencyDropdownState extends State<CurrencyDropdown> {
  List<Currency> currencies = [GBP(), EUR(), USD(), HUF(), JPY(), NGN()];

  String selectedCurrency = GBP().name;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedCurrency,

      items: currencies.map((Currency currency) {
        return DropdownMenuItem<String>(
          value: currency.name,
          child: Text(currency.name),
        );
      }).toList(),

      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            selectedCurrency = newValue;

            Currency chosenCurrency = currencies.firstWhere(
              (currency) => currency.name == newValue,
            );

            widget.onCurrencyChanged(chosenCurrency);
          });
        }
      },
    );
  }
}

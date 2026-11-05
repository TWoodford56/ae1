import 'package:flutter/material.dart';

class Currency {
  const Currency({
    required this.unitsPerPound,
    required this.sign,
    required this.name,
  });

  final double unitsPerPound;
  final String sign;
  final String name;
}

class CurrencyHelper {
  final List<Currency> currencies = [GBP(), EUR(), USD(), HUF(), JPY(), NGN()];

  double calculateCurrency(Currency c1, Currency c2, double Total) {
    double gbpAmount = Total / c1.unitsPerPound;

    double conversion = gbpAmount * c2.unitsPerPound;
    return double.parse(conversion.toStringAsFixed(2));
  }
}

class GBP extends Currency {
  const GBP({
    double value = 1,
    String symbol = '£',
    String currencyName = 'GBP',
  }) : super(unitsPerPound: value, sign: symbol, name: currencyName);
}

class USD extends Currency {
  const USD({
    double value = 1.34,
    String symbol = '\$',
    String currencyName = 'USD',
  }) : super(unitsPerPound: value, sign: symbol, name: currencyName);
}

class EUR extends Currency {
  const EUR({
    double value = 1.19,
    String symbol = '€',
    String currencyName = 'EUR',
  }) : super(unitsPerPound: value, sign: symbol, name: currencyName);
}

class JPY extends Currency {
  const JPY({
    double value = 213,
    String symbol = '¥',
    String currencyName = 'JPY',
  }) : super(unitsPerPound: value, sign: symbol, name: currencyName);
}

class NGN extends Currency {
  const NGN({
    double value = 1814.10,
    String symbol = '₦',
    String currencyName = 'NGN',
  }) : super(unitsPerPound: value, sign: symbol, name: currencyName);
}

class HUF extends Currency {
  const HUF({
    double value = 435,
    String symbol = 'Ft',
    String currencyName = 'HUF',
  }) : super(unitsPerPound: value, sign: symbol, name: currencyName);
}

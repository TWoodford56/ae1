import 'package:flutter/material.dart';

class Currency {
  const Currency({required this.unitsPerPound, required this.sign});

  final double unitsPerPound;
  final String sign;

  double calculateCurrency(Currency c1, Currency c2, double Total) {
    double gbpAmount = Total / c1.unitsPerPound;

    double conversion = gbpAmount * c2.unitsPerPound;
    return double.parse(conversion.toStringAsFixed(2));
  }
}

class GBP extends Currency {
  const GBP({double value = 1, String symbol = '£'})
    : super(unitsPerPound: value, sign: symbol);
}

class USD extends Currency {
  const USD({double value = 1.34, String symbol = '\$'})
    : super(unitsPerPound: value, sign: symbol);
}

class EUR extends Currency {
  const EUR({double value = 1.19, String symbol = '€'})
    : super(unitsPerPound: value, sign: symbol);
}

class JPY extends Currency {
  const JPY({double value = 213, String symbol = '¥'})
    : super(unitsPerPound: value, sign: symbol);
}

class NGN extends Currency {
  const NGN({double value = 1814.10, String symbol = '₦'})
    : super(unitsPerPound: value, sign: symbol);
}

class HUF extends Currency {
  const HUF({double value = 435, String symbol = 'Ft'})
    : super(unitsPerPound: value, sign: symbol);
}

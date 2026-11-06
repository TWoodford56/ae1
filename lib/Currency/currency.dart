///FIle:
///INcludes rate table alongside currency codes and symbols
///currency conversion logic
///Rates are accurate as of 04/11/26 via xe

class Currency {
  // Creates a currency with everything needed to convert and display it.
  const Currency({
    required this.name,
    required this.sign,
    required this.unitsPerPound,
  });

  // Three-letter code shown in the UI, e.g. `USD`.
  final String name;

  // Symbol shown before amounts, e.g. `$`.
  final String sign;

  // How many units of this currency are equal to 1 GBP.
  final double unitsPerPound;
}

/// list of currencies
const List<Currency> supportedCurrencies = [
  Currency(name: 'GBP', sign: '£', unitsPerPound: 1),
  Currency(name: 'USD', sign: '\$', unitsPerPound: 1.34), //brief provides different rate, however i wanted consistent rates at the date stated at the top
  Currency(name: 'EUR', sign: '€', unitsPerPound: 1.19),
  Currency(name: 'JPY', sign: '¥', unitsPerPound: 213),
  Currency(name: 'HUF', sign: 'Ft', unitsPerPound: 435),
  Currency(name: 'NGN', sign: '₦', unitsPerPound: 1814.10),
];

/// Conversion class
class CurrencyHelper {
  double rate(Currency from, Currency to) =>
      to.unitsPerPound / from.unitsPerPound;

  // Converts from one currency into the other
  double convert(Currency from, Currency to, double amount) =>
      amount * rate(from, to);

  // limits decimal points to 2 for the amounts
  String formatAmount(double value) => value.toStringAsFixed(2);
  //limits decimal points to 5 for the rates
  String formatRate(double rate) =>
      double.parse(rate.toStringAsFixed(5)).toString();
}

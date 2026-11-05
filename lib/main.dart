import 'package:flutter/material.dart';
import 'package:ae1/widgets/CurrencyDropwdown.dart';
import 'package:ae1/Currency/currency.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //this widget is the root
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Converter',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepOrangeAccent),
      ),
      home: const CurrencyConverter(),
    );
  }
}

// The converter screen.
class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  CurrencyHelper ch = CurrencyHelper();

  // Amount typed by the user, empty = 0
  double _total = 0.0;
  Currency fromCurrency = supportedCurrencies[1]; // USD
  Currency toCurrency = supportedCurrencies[0]; // GBP

  // Swaps the "from" and "to" currencies in one action.
  void _swapCurrencies() {
    setState(() {
      Currency temp = fromCurrency;
      fromCurrency = toCurrency;
      toCurrency = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    double fxRate = ch.rate(fromCurrency, toCurrency);
    String result = ch.formatAmount(
      ch.convert(fromCurrency, toCurrency, _total),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: theme.colorScheme.primary, width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText:
                                '${fromCurrency.sign}${fromCurrency.name}',
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (String value) {
                            setState(() {
                              // negative or invalid input counts as 0
                              _total = (double.tryParse(value) ?? 0.0)
                                  .clamp(0.0, 1e12)
                                  .toDouble();
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      CurrencyDropdown(
                        value: fromCurrency,
                        onCurrencyChanged: (Currency currency) {
                          setState(() {
                            fromCurrency = currency;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // swap button between the two currencies
          Center(
            child: IconButton(
              onPressed: _swapCurrencies,
              icon: const Icon(Icons.swap_vert_rounded, size: 35),
              style: IconButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(12),
              ),
            ),
          ),

          // "They receive": converted amount and the to currency
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: theme.colorScheme.inversePrimary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${toCurrency.sign}$result',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CurrencyDropdown(
                        value: toCurrency,
                        onCurrencyChanged: (Currency currency) {
                          setState(() {
                            toCurrency = currency;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.inversePrimary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '1 ${fromCurrency.name} = ${ch.formatRate(fxRate)} ${toCurrency.name}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

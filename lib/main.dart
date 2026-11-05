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
      home: CurrencyConverter(),
    );
  }
}

class CurrencyConverter extends StatefulWidget {
  const new({super.key});

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  ValueChanged<double>? get onChanged => null;

  CurrencyHelper ch = new CurrencyHelper();

  double _total = 0.0;
  Currency fromCurrency = GBP();
  Currency toCurrency = GBP();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final style = theme.textTheme.titleMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CurrencyDropdown(
                      onCurrencyChanged: (Currency currency) {
                        setState(() {
                          fromCurrency = currency;
                        });
                      },
                    ),
                    CurrencyDropdown(
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: theme.colorScheme.primary, width: 2),
              ),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: '${fromCurrency.sign}${fromCurrency.name}',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (String value) {
                      setState(() {
                        _total = double.tryParse(value) ?? 0.0;
                      });
                      ;
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 56,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: theme.colorScheme.primary, width: 1),
              ),
              child: Text(
                '${toCurrency.sign}${ch.calculateCurrency(fromCurrency, toCurrency, _total)}',
                style: theme.textTheme.bodyLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ae1/widgets/TravellerCount.dart';
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
      title: 'TriCount',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepOrangeAccent),
      ),
      home: TriCount(),
    );
  }
}

class TriCount extends StatefulWidget {
  const new({super.key});

  @override
  State<TriCount> createState() => _TriCountState();
}

class _TriCountState extends State<TriCount> {
  ValueChanged<double>? get onChanged => null;

  int _personCount = 1;
  double _giftPercentage = 0.0;
  double _billTotal = 0.0;

  double get _tipAmount => _billTotal * _giftPercentage;
  double get _perPerson => (_billTotal + _tipAmount) / _personCount;

  //Methods
  void increment() {
    setState(() {
      _personCount = _personCount + 1;
    });
  }

  void decrement() {
    setState(() {
      if (_personCount > 0) {
        _personCount = _personCount - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final style = theme.textTheme.titleMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
      fontWeight: FontWeight.bold,
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Fuel Cost Sharing')),
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
                Text('Total Fuel Cost Per Traveller', style: style),
                Text(
                  '$_perPerson',
                  style: style.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontSize: theme.textTheme.displaySmall?.fontSize,
                  ),
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
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Fuel Cost',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (String value) {
                      setState(() {
                        _billTotal = double.tryParse(value) ?? 0.0;
                      });
                      ;
                    },
                  ),

                  //Split Bill area
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Split", style: theme.textTheme.titleMedium),
                      TravellerCount(
                        personCount: _personCount,
                        theme: theme,
                        onDecrement: decrement,
                        onIncrement: increment,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tip', style: theme.textTheme.titleMedium),
                      Text('20', style: theme.textTheme.titleMedium),
                    ],
                  ),
                  Text('${(_giftPercentage * 100).round()}%'),
                  Slider(
                    value: _giftPercentage,
                    onChanged: (value) {
                      setState(() {
                        _giftPercentage = value;
                      });
                      _giftPercentage = value;
                    },
                    min: 0,
                    max: 0.5,
                    divisions: 5,
                    label: '${(_giftPercentage * 100).round()}%',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

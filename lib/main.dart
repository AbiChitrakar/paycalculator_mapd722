import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController hoursController = TextEditingController();
  TextEditingController rateController = TextEditingController();

  double regularPay = 0.0;
  double overtimePay = 0.0;
  double totalPay = 0.0;
  double tax = 0.0;

  String errorText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Prevent resizing when the keyboard is opened
      appBar: AppBar(
        title: const Text('Pay Calculator'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                // Main Part
                children: [
                  const SizedBox(height: 16),
                  TextField(
                    controller: hoursController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      labelText: 'Number of Hours Worked',
                      errorText: errorText.isEmpty ? null : errorText,
                      labelStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                  TextField(
                    controller: rateController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      labelText: 'Hourly Rate',
                      errorText: errorText.isEmpty ? null : errorText,
                      labelStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: validateAndCalculatePay,
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).hintColor,
                      textStyle: TextStyle(fontSize: 18),
                    ),
                    child: Text('Calculate Pay'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Regular Pay: $regularPay',
                    style: TextStyle(fontSize: 18, color: Colors.green),
                  ),
                  Text(
                    'Overtime Pay: $overtimePay',
                    style: TextStyle(fontSize: 18, color: Colors.green),
                  ),
                  Text(
                    'Total Pay: $totalPay',
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                  Text(
                    'Tax: $tax',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              // About Part
              children: [
                SizedBox(height: 8),
                Text(
                  'About Part',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).hintColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Name: Abi Chitrakar',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'College ID: 301369773',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void validateAndCalculatePay() {
    double? hours = double.tryParse(hoursController.text);
    double? rate = double.tryParse(rateController.text);

    if (hours == null || hours <= 0 || rate == null || rate <= 0) {
      setErrorText('Please enter valid numerical values');
    } else {
      setErrorText('');
      calculatePay();
    }
  }

  void setErrorText(String error) {
    setState(() {
      errorText = error;
    });
  }

  void calculatePay() {
    double hours = double.tryParse(hoursController.text) ?? 0.0;
    double rate = double.tryParse(rateController.text) ?? 0.0;

    if (hours <= 40) {
      regularPay = hours * rate;
      overtimePay = 0.0;
    } else {
      regularPay = 40 * rate;
      overtimePay = (hours - 40) * rate * 1.5;
    }

    totalPay = regularPay + overtimePay;
    tax = totalPay * 0.18;

    setState(() {});
  }
}

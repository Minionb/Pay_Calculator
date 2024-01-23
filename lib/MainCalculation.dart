import 'package:flutter/material.dart';

class MainCalculation extends StatefulWidget{
    @override
  MainCalculationState createState() => MainCalculationState();
}
class MainCalculationState extends State<MainCalculation> {
  var hours = 0.0;
  var hourlyRate = 0.0;
  var regularPay = 0.0;
  var overtimePay = 0.0;
  var totalPay = 0.0;
  var tax = 0.0;

  TextEditingController hoursController = TextEditingController();
  TextEditingController hourlyRateController = TextEditingController();

  // Caculate payment result function
  void calculateResult(double hours, double hourlyRate) {

    if(hours <= 40 && hours > 0){
      totalPay = hours * hourlyRate;
      regularPay = totalPay;
      overtimePay = 0;
      tax = totalPay * 0.18;
    }
    else if (hours > 40){
      overtimePay = (hours - 40) * hourlyRate * 1.5;
      regularPay = 40 * hourlyRate;
      totalPay = overtimePay + regularPay;
      tax = totalPay * 0.18;
    }
    hours = 0.0;
    hourlyRate = 0.0;
  }

  // Validate user input function
  bool validateInput() {
    if (hours <= 0 || hourlyRate <= 0) {
      setState(() {
        hours = 0;
        hourlyRate = 0;
        regularPay = 0;
        overtimePay = 0;
        totalPay = 0;
        tax = 0;
      });
    hourlyRate = 0.0;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Input Error'),
            content: const Text('Please enter valid number of hours and hourly rate.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  hoursController.clear();
                  hourlyRateController.clear();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return false;
    }
    return true;
  }

// Main part UI design
@override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 3.0,
                ),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: TextField(
                controller: hoursController,
                 onChanged: (value) {
                 final parsedValue = double.tryParse(value) ?? 0.0;
                 setState(() {
                  hours = parsedValue;
                });
              },
                decoration: const InputDecoration(
                  labelText: 'Number of Hours',
                  border: InputBorder.none
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 3.0,
                ),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: TextField(
                controller: hourlyRateController,
                onChanged: (value) {
                 final parsedValue = double.tryParse(value) ?? 0.0;
              setState(() {
                hourlyRate = parsedValue;
              });
              },
                decoration: const InputDecoration(
                  labelText: 'Hourly Rate',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
              if (validateInput()) {
                setState(() {
                  calculateResult(hours,hourlyRate);
                });
              }
              },
              child: const Text('Calculate'),
            ),

            const SizedBox(height: 18.0),

            Container(
            width: 350.0,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 3.0,
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Report',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Regular Pay: \$${regularPay.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  'Overtime Pay: \$${overtimePay.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  'Total Pay: \$${totalPay.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Text(
                  'Tax: \$${tax.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                ],
            ),
          ),
          ],
        ),
      );
  }
}
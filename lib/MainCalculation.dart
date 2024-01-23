import 'package:flutter/material.dart';

class MainCalculation extends StatefulWidget{
    @override
  MainCalculationState createState() {
    return MainCalculationState();
    }
}
class MainCalculationState extends State<MainCalculation> {
  var hours = 0.0;
  var hourlyRate = 0.0;
  var regularPay = 0.0;
  var overtimePay = 0.0;
  var totalPay = 0.0;
  var tax = 0.0;

  // Controller to set the value to be blank if the entered value cannot pass the validation
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
    // if wrong value
    if (hours <= 0 || hourlyRate <= 0) {
      // set all the value state to 0
      setState(() {
        hours = 0;
        hourlyRate = 0;
        regularPay = 0;
        overtimePay = 0;
        totalPay = 0;
        tax = 0;
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          // alert for wrong value
          return AlertDialog(
            title: const Text('Input Error'),
            content: const Text('Please enter valid number of hours and hourly rate.'),
            actions: [
              TextButton(
                onPressed: () {
                  // clear the input value if wrong value
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
              // Number of Hours Text Field
              child: TextField(
                controller: hoursController,
                 onChanged: (value) {
                // set the hours state to the input value, set it to 0.0 if the value cannot be parsed to double
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
              // Hourly Rate Text Field
              child: TextField(
                controller: hourlyRateController,
                onChanged: (value) {
                // set the hourlyRate state to the input value, set it to 0.0 if the value cannot be parsed to double
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
              // Calculate button: will run calculateResult function if validateInput is true
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

            // Calculation Report Container
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
              // Displaying the Calculation Report Result
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
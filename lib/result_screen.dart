import 'package:flutter/material.dart';

class BMIResultScreen extends StatelessWidget {
  final double bmi;

  BMIResultScreen({required this.bmi});

  String getBMICategory() {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Normal';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  String getRecommendation() {
    if (bmi < 18.5) {
      return 'You should increase your calorie intake to gain healthy weight.';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'You are within a normal weight range. Keep maintaining your healthy lifestyle!';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'You may want to consider losing weight by exercising and following a healthy diet.';
    } else {
      return 'It is recommended that you consult with a healthcare provider for personalized advice.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text('BMI Result'),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your BMI is ${bmi.toStringAsFixed(1)}',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Category: ${getBMICategory()}',
                style: TextStyle(fontSize: 22, color: Colors.green),
              ),
              SizedBox(height: 20),
              Text(
                getRecommendation(),
                style: TextStyle(fontSize: 18, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

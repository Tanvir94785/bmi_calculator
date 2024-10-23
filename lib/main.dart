import 'package:bmi_calculator/result_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BMICalculatorScreen(),
    );
  }
}

class BMICalculatorScreen extends StatefulWidget {
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  bool isMale = true;
  int feet = 5;
  int inches = 8;
  double weight = 65;
  double bmi = 0;

  // Convert feet and inches to cm
  double getHeightInCm() {
    return (feet * 30.48) + (inches * 2.54);
  }

  void calculateBMI() {
    double heightCm = getHeightInCm();
    bmi = weight / ((heightCm / 100) * (heightCm / 100));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BMIResultScreen(bmi: bmi),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text('BMI Calculator'),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Gender',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GenderSelection(
                  isSelected: isMale,
                  icon: Icons.male,
                  label: 'Male',
                  onTap: () {
                    setState(() {
                      isMale = true;
                    });
                  },
                ),
                SizedBox(width: 20),
                GenderSelection(
                  isSelected: !isMale,
                  icon: Icons.female,
                  label: 'Female',
                  onTap: () {
                    setState(() {
                      isMale = false;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Height',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Feet Selector
                Column(
                  children: [
                    Text('Feet', style: TextStyle(fontSize: 18)),
                    DropdownButton<int>(
                      value: feet,
                      items: List.generate(8, (index) => index + 1)
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          feet = newValue!;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(width: 20),
                // Inches Selector
                Column(
                  children: [
                    Text('Inches', style: TextStyle(fontSize: 18)),
                    DropdownButton<int>(
                      value: inches,
                      items: List.generate(12, (index) => index)
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          inches = newValue!;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Weight',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Slider(
              value: weight,
              min: 40,
              max: 120,
              divisions: 80,
              label: weight.toString(),
              onChanged: (newValue) {
                setState(() {
                  weight = newValue;
                });
              },
            ),
            Text(
              '${weight.toStringAsFixed(1)} kg',
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: calculateBMI,
              child: Text('Calculate BMI', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GenderSelection extends StatelessWidget {
  final bool isSelected;
  final IconData icon;
  final String label;
  final Function onTap;

  GenderSelection({
    required this.isSelected,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.green[100] : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isSelected ? Colors.green : Colors.grey),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Icon(icon,
                size: 60, color: isSelected ? Colors.green : Colors.grey),
            SizedBox(height: 10),
            Text(label,
                style: TextStyle(
                    fontSize: 18,
                    color: isSelected ? Colors.green : Colors.grey)),
          ],
        ),
      ),
    );
  }
}

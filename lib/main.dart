import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Loan Calculator',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      home: HomeLoanCalculator(),
    );
  }
}

class HomeLoanCalculator extends StatefulWidget {
  @override
  _HomeLoanCalculatorState createState() => _HomeLoanCalculatorState();
}

class _HomeLoanCalculatorState extends State<HomeLoanCalculator> {
  int loanAmount = 2500000;
  int years = 30;
  double interestRate = 8.75;
  double monthlyEMI = 0;
  double totalInterest = 0;
  double totalPrincipal = 0;

  TextEditingController loanAmountController = TextEditingController();
  TextEditingController yearsController = TextEditingController();
  TextEditingController interestRateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loanAmountController.text = loanAmount.toString();
    yearsController.text = years.toString();
    interestRateController.text = interestRate.toString();
    calculateEMI();
  }

  void calculateEMI() {
    double principal = loanAmount.toDouble();
    double rateOfInterest = interestRate / 1200;
    double numberOfPayments = years * 12;

    monthlyEMI = ((principal * rateOfInterest) /
            (1 - pow(1 + rateOfInterest, -numberOfPayments)))
        .roundToDouble();

    totalPrincipal = loanAmount.toDouble();
    totalInterest = (monthlyEMI * numberOfPayments) - totalPrincipal;

    setState(() {});
  }

  @override
  void dispose() {
    loanAmountController.dispose();
    yearsController.dispose();
    interestRateController.dispose();
    super.dispose();
  }

  void updateLoanAmount(String value) {
    setState(() {
      loanAmount = int.tryParse(value) ?? loanAmount;
      calculateEMI();
    });
  }

  void updateYears(String value) {
    setState(() {
      years = int.tryParse(value) ?? years;
      calculateEMI();
    });
  }

  void updateInterestRate(String value) {
    setState(() {
      interestRate = double.tryParse(value) ?? interestRate;
      calculateEMI();
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalAmountPayable = totalPrincipal + totalInterest;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Loan Calculator'),
        backgroundColor: Color.fromARGB(255, 58, 74, 194),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Home Loan Products', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Checklist & Calculators', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Banking Products', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Deposits', style: TextStyle(color: Colors.white)),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: Colors.white),
          ),
          TextButton(
            onPressed: () {},
            child: Text('Login', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sliders Container
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text('Loan Amount')),
                      Container(
                        width: 100,
                        child: TextField(
                          controller: loanAmountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Loan Amount',
                          ),
                          onSubmitted: updateLoanAmount,
                          onChanged: (value) {
                            setState(() {
                              loanAmount = int.tryParse(value) ?? loanAmount;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      thumbShape: CustomSliderThumbCircle(
                        thumbRadius: 12,
                        thumbColor: Colors.white,
                        borderColor: Colors.blue,
                      ),
                      overlayColor: Colors.blue.withOpacity(0.3),
                      activeTrackColor: Colors.blue,
                      inactiveTrackColor: Colors.blue.withOpacity(0.5),
                      trackHeight: 4,
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
                    ),
                    child: Slider(
                      value: loanAmount.toDouble(),
                      min: 100000,
                      max: 100000000,
                      divisions: 490,
                      label: 'Loan Amount: $loanAmount',
                      onChanged: (value) {
                        setState(() {
                          loanAmount = value.toInt();
                          loanAmountController.text = loanAmount.toString();
                        });
                        calculateEMI();
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(child: Text('Years')),
                      Container(
                        width: 100,
                        child: TextField(
                          controller: yearsController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Years',
                          ),
                          onSubmitted: updateYears,
                          onChanged: (value) {
                            setState(() {
                              years = int.tryParse(value) ?? years;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      thumbShape: CustomSliderThumbCircle(
                        thumbRadius: 12,
                        thumbColor: Colors.white,
                        borderColor: Colors.blue,
                      ),
                      overlayColor: Colors.blue.withOpacity(0.3),
                      activeTrackColor: Colors.blue,
                      inactiveTrackColor: Colors.blue.withOpacity(0.5),
                      trackHeight: 4,
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
                    ),
                    child: Slider(
                      value: years.toDouble(),
                      min: 1,
                      max: 30,
                      divisions: 29,
                      label: 'Years: $years',
                      onChanged: (value) {
                        setState(() {
                          years = value.toInt();
                          yearsController.text = years.toString();
                        });
                        calculateEMI();
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(child: Text('Interest Rate')),
                      Container(
                        width: 100,
                        child: TextField(
                          controller: interestRateController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Interest Rate',
                          ),
                          onSubmitted: updateInterestRate,
                          onChanged: (value) {
                            setState(() {
                              interestRate = double.tryParse(value) ?? interestRate;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      thumbShape: CustomSliderThumbCircle(
                        thumbRadius: 12,
                        thumbColor: Colors.white,
                        borderColor: Colors.blue,
                      ),
                      overlayColor: Colors.blue.withOpacity(0.3),
                      activeTrackColor: Colors.blue,
                      inactiveTrackColor: Colors.blue.withOpacity(0.5),
                      trackHeight: 4,
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
                    ),
                    child: Slider(
                      value: interestRate,
                      min: 0.5,
                      max: 15,
                      divisions: 190,
                      label: 'Interest Rate: $interestRate%',
                      onChanged: (value) {
                        setState(() {
                          interestRate = value;
                          interestRateController.text = interestRate.toString();
                        });
                        calculateEMI();
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20), // Add some space between the sections

            // Information Container
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(16),
                color: Colors.white,
                child: SizedBox.expand(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Monthly EMI: \$${monthlyEMI.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Principal Amount: \$${totalPrincipal.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Interest Amount: \$${totalInterest.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Total Amount Payable: \$${totalAmountPayable.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            // Add your logic for contacting loan expert
                          },
                          child: Text('Talk to Loan Expert'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            textStyle: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 20), // Add some space between the sections

            // Pie Chart Container
            Flexible(
              flex: 1,
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Container(
                    color: Colors.white,
                    child: PieChart(
                      PieChartData(
                        sections: getSections(totalInterest, totalPrincipal),
                        sectionsSpace: 5,
                        centerSpaceRadius: 0,
                        pieTouchData: PieTouchData(enabled: false),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> getSections(double interest, double principal) {
    return [
      PieChartSectionData(
        color: Color.fromARGB(255, 132, 187, 213),
        value: interest,
        title: '\$${interest.toStringAsFixed(2)}',
        radius: 105,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        showTitle: true,
      ),
      PieChartSectionData(
        color: Color.fromARGB(255, 70, 132, 183),
        value: principal,
        title: '\$${principal.toStringAsFixed(2)}',
        radius: 100,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        showTitle: true,
      ),
    ];
  }
}

class CustomSliderThumbCircle extends SliderComponentShape {
  final double thumbRadius;
  final Color thumbColor;
  final Color borderColor;

  CustomSliderThumbCircle({
    required this.thumbRadius,
    required this.thumbColor,
    required this.borderColor,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    TextPainter? labelPainter,
    RenderBox? parentBox,
    SliderThemeData? sliderTheme,
    TextDirection? textDirection,
    double? value,
    double? textScaleFactor,
    Size? sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Paint thumbPaint = Paint()
      ..color = thumbColor
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(center, thumbRadius, thumbPaint);
    canvas.drawCircle(center, thumbRadius, borderPaint);
  }
}


import 'package:flutter/material.dart';
import 'about_page.dart';

import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController weightController =
  TextEditingController();

  final TextEditingController rateController =
  TextEditingController();

  String selectedClass = 'Economy';

  double? excessWeight;
  double? excessCharge;
  double? serviceTax;
  double? totalPayable;

  double get baggageAllowance {
    return selectedClass == 'Economy' ? 20.0 : 40.0;
  }

  void calculateFee() {
    if (weightController.text.trim().isEmpty ||
        rateController.text.trim().isEmpty) {
      showMessage('Please fill in all fields.');
      return;
    }

    final double? weight =
    double.tryParse(weightController.text.trim());

    final double? rate =
    double.tryParse(rateController.text.trim());

    if (weight == null ||
        rate == null ||
        !weight.isFinite ||
        !rate.isFinite) {
      showMessage('Please enter valid numbers.');
      return;
    }

    if (weight < 0 || rate < 0) {
      showMessage('Values cannot be negative.');
      return;
    }

    setState(() {
      excessWeight = (weight - baggageAllowance)
          .clamp(0.0, double.infinity);

      excessCharge = excessWeight! * rate;

      serviceTax = excessCharge! * 0.08;

      totalPayable = excessCharge! + serviceTax!;
    });
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade700,
      ),
    );
  }

  void resetCalculator() {
    setState(() {
      weightController.clear();
      rateController.clear();

      selectedClass = 'Economy';

      excessWeight = null;
      excessCharge = null;
      serviceTax = null;
      totalPayable = null;
    });
  }

  @override
  void dispose() {
    weightController.dispose();
    rateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Excess Baggage Calculator',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      drawer: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: primaryGreen,
              ),
              accountName: Text(
                'Excess Baggage Calculator',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text('Mobile Application'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.luggage,
                  color: primaryGreen,
                  size: 35,
                ),
              ),
            ),

            ListTile(
              leading: const Icon(
                Icons.home,
                color: primaryGreen,
              ),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(
              leading: const Icon(
                Icons.info,
                color: primaryGreen,
              ),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            const Icon(
              Icons.luggage,
              size: 75,
              color: primaryGreen,
            ),

            const SizedBox(height: 10),

            const Text(
              'Calculate Your Excess Baggage Fee',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryGreen,
              ),
            ),

            const SizedBox(height: 15),

            // Instructions

            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: lightGreen,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Instructions:\n'
                    '1. Select your ticket class.\n'
                    '2. Enter your baggage weight in kg.\n'
                    '3. Enter the excess baggage rate per kg.\n'
                    '4. Press Calculate Fee to view your result.\n\n'
                    'Note: An additional 8% service tax applies '
                    'to the excess baggage charge.',
                style: TextStyle(fontSize: 13),
              ),
            ),

            const SizedBox(height: 25),

            // Ticket Class

            const Text(
              'Ticket Class',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              initialValue: selectedClass,

              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.airplane_ticket,
                  color: primaryGreen,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              items: const [
                DropdownMenuItem(
                  value: 'Economy',
                  child: Text('Economy (20 kg allowance)'),
                ),
                DropdownMenuItem(
                  value: 'Business',
                  child: Text('Business (40 kg allowance)'),
                ),
              ],

              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  selectedClass = value;

                  excessWeight = null;
                  excessCharge = null;
                  serviceTax = null;
                  totalPayable = null;
                });
              },
            ),

            const SizedBox(height: 20),

            // Baggage Weight

            const Text(
              'Checked Baggage Weight (kg)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: weightController,

              keyboardType:
              const TextInputType.numberWithOptions(
                decimal: true,
              ),

              decoration: InputDecoration(
                hintText: 'Enter baggage weight',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.scale,
                  color: primaryGreen,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Excess Baggage Rate

            const Text(
              'Excess Baggage Rate (RM per kg)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: rateController,

              keyboardType:
              const TextInputType.numberWithOptions(
                decimal: true,
              ),

              decoration: InputDecoration(
                hintText: 'Enter rate per kg',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.payments,
                  color: primaryGreen,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Calculate Button

            ElevatedButton.icon(
              onPressed: calculateFee,
              icon: const Icon(Icons.calculate),
              label: const Text(
                'Calculate Fee',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Reset Button

            OutlinedButton.icon(
              onPressed: resetCalculator,
              icon: const Icon(Icons.refresh),
              label: const Text('Reset'),

              style: OutlinedButton.styleFrom(
                foregroundColor: primaryGreen,
                side: const BorderSide(
                  color: primaryGreen,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Calculation Result

            if (totalPayable != null) ...[
              Container(
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: lightGreen,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: primaryGreen,
                  ),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Text(
                      'Calculation Result',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryGreen,
                      ),
                    ),

                    const Divider(),

                    resultRow(
                      'Baggage Allowance',
                      '${baggageAllowance.toStringAsFixed(1)} kg',
                    ),

                    resultRow(
                      'Excess Baggage Weight',
                      '${excessWeight!.toStringAsFixed(2)} kg',
                    ),

                    resultRow(
                      'Excess Baggage Charge',
                      'RM ${excessCharge!.toStringAsFixed(2)}',
                    ),

                    resultRow(
                      'Service Tax (8%)',
                      'RM ${serviceTax!.toStringAsFixed(2)}',
                    ),

                    const Divider(),

                    resultRow(
                      'Total Amount Payable',
                      'RM ${totalPayable!.toStringAsFixed(2)}',
                      isTotal: true,
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget resultRow(
      String label,
      String value, {
        bool isTotal = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: isTotal
                    ? FontWeight.bold
                    : FontWeight.normal,
                fontSize: isTotal ? 16 : 14,
              ),
            ),
          ),

          const SizedBox(width: 10),

          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isTotal ? 17 : 14,
              color: primaryGreen,
            ),
          ),
        ],
      ),
    );
  }
}

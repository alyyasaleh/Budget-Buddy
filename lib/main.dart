import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
   State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
TextEditingController expenses = TextEditingController();
TextEditingController dailyLimit = TextEditingController();

String result = " ";
String balance = " ";
 final player = AudioPlayer();


 void resetFields() {
  setState(() {
    expenses.clear();
    dailyLimit.clear();
    result = "";
    balance = "";
  });
}

  void checkExpense() {
    double expense = double.parse(expenses.text);
    double limit = double.parse(dailyLimit.text);

    setState(() {
      double remaining = limit - expense;
      balance = "Remaining: RM ${remaining.toStringAsFixed(2)}";

      if (expense < limit) {
        result = "Within budget";
      } else if (expense == limit) {
        result = "Limit reached ⚠️";
      } else {
        result = "Over budget 🚨";
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Budget Buddy"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/wallet.png', height: 90, width: 90),

            SizedBox(height: 20),
            TextField(
              controller: expenses,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Expenses",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: dailyLimit,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Daily Limit",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: checkExpense, 
              child: const Text("Check"),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(result, style: TextStyle(fontSize: 18)),
                SizedBox(width: 20),
                Text(balance, style: TextStyle(fontSize: 18)),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                resetFields();
              },
              child: Text("Reset"),
            ),
          ],
        ),
      ), 
      );
  }
}

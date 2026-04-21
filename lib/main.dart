import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Buddy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 25, 36, 100)),
        useMaterial3: true,
      ),
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
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/wallet.png', height: 85, width: 85),

            SizedBox(height: 20),
            SizedBox(
              width: 290,
              child: TextField(
                controller: expenses,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Expenses",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 290,
              child: TextField(
                controller: dailyLimit,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Daily Limit",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
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

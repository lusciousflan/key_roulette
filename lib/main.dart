import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'key_roulette',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'key roulette'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List> memberlist = [];
  String duty = "";

  void roulette() async {
    // memberlist = await csvImport();
    final String csv = await rootBundle.loadString('assets/list.csv');
    // print("${csv}");
    for(String line in csv.split('\n')) {
      List rows = line.split(',');
      memberlist.add(rows);
    }
    memberlist.shuffle();
    setState(() {
      duty = memberlist[math.Random().nextInt(memberlist.length)][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '鍵当番は？',
              style: TextStyle(fontSize: MediaQuery.of(context).size.width/15),
            ),
            Text('$duty', style: TextStyle(fontSize: MediaQuery.of(context).size.width/15)),
            ElevatedButton(
              onPressed: roulette, 
              child: Text("抽選", style: TextStyle(fontSize: MediaQuery.of(context).size.width/10),),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  duty = "";
                });
              },
              child: Text("リセット", style: TextStyle(fontSize: MediaQuery.of(context).size.width/10),),
            ),
          ],
        ),
      ),
    );
  }
}

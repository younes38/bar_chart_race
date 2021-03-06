import 'package:bar_chart_race/bar_chart_race.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // is not restarted.
        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RandomDataExample(),
    );
  }
}

class RandomDataExample extends StatefulWidget {
  @override
  _RandomDataExampleState createState() => _RandomDataExampleState();
}

class _RandomDataExampleState extends State<RandomDataExample> {
  List<List<double>> data;
  bool isPlaying = false;
  @override
  void initState() {
    data = generateGoodRandomData(20, 5);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bar chart race"),
        backgroundColor: Colors.brown,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 150,
          ),
          BarChartRace(
            data: data,
            initialPlayState: true,
            columnsColor: [
              Color(0xFFFF9900),
              Color(0xFF4285F4),
              Color(0xFFA2AAAD),
              Color(0xFFF40009),
              Color(0xFF212326),
            ],
            framesPerSecond: 60,
            framesBetweenTwoStates: 30,
            numberOfRactanglesToShow: 4,
            title: "Top companies revenue",
            columnsLabel: ["Amazon", "Google", "Apple", "Coca", "Huawei"],
            statesLabel: List.generate(
              30,
              (index) => formatDate(
                DateTime.now().add(
                  Duration(days: index),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<List<double>> generateGoodRandomData(int nbRows, int nbColumns) {
    List<List<double>> data = List.generate(nbRows, (index) => List());
    for (int j = 0; j < nbColumns; j++) {
      data[0].add(j * 10.0);
    }
    for (int i = 1; i < nbRows; i++) {
      for (int j = 0; j < nbColumns; j++) {
        data[i].add(data[i - 1][j] +
            (nbColumns - j) +
            math.Random().nextDouble() * 20 +
            (j == 2 ? 10 : 0));
      }
    }
    return data;
  }

  formatDate(DateTime date) {
    int day = date.day;
    int month = date.month;
    int year = date.year;
    return "${months[month - 1]} $day, $year";
  }
}

List<String> months = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
];

List<String> weekDays = [
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday",
];

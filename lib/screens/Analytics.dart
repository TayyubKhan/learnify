
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../res/ScoreStoring.dart';
import '../res/color.dart';

class AnalyticScreen extends StatefulWidget {
  const AnalyticScreen({super.key});

  @override
  State<AnalyticScreen> createState() => _AnalyticScreenState();
}

class _AnalyticScreenState extends State<AnalyticScreen> {
  List<Map<String, dynamic>?> data = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    st.returnScore().then((value) {
      if (kDebugMode) {
        print(value.length);
      }
      data = value;
      setState(() {});
    });
  }

  final st = StoreScore();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Analytics',
          style: TextStyle(color: font, fontSize: 40),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: background,
      body: Center(
        child: SizedBox(
          height: height * 0.5,
          child: BarChart(
            BarChartData(
              borderData: FlBorderData(
                show: false,
              ),
              gridData: const FlGridData(show: false),
              titlesData: FlTitlesData(
                show: true,
                leftTitles: const AxisTitles(),
                topTitles: const AxisTitles(),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    getTitlesWidget: (value, meta) => Text(
                      ['Writing', 'Recognition'][value.toInt()],
                      style: const TextStyle(fontSize: 22, color: font),
                    ),
                    showTitles: true,
                  ),
                ),
              ),
              alignment: BarChartAlignment.spaceAround,
              maxY: 100,
              barGroups: [
                BarChartGroupData(
                  x: 0,
                  barRods: [
                    BarChartRodData(
                      borderRadius: BorderRadius.circular(5),
                      width: 18,
                      color: const Color(0xff120A4F),
                      toY: double.parse(data[0]!['value'].toString()),
                    ),
                  ],
                ),
                BarChartGroupData(
                  x: 1,
                  barRods: [
                    BarChartRodData(
                      borderRadius: BorderRadius.circular(5),
                      width: 18,
                      color: Colors.green,
                      toY: double.parse(data[1]!['value'].toString()),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

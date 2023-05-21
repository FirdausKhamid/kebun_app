import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kebun_app/screens/yield/bar_data.dart';

class MyBarGraph extends StatelessWidget {
  final List monthlySummary;
  MyBarGraph({super.key, required this.monthlySummary});

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      JanuaryAmount: monthlySummary[0],
      FebruaryAmount: monthlySummary[1],
      MarchAmount: monthlySummary[2],
      AprilAmount: monthlySummary[3],
      MayAmount: monthlySummary[4],
      JuneAmount: monthlySummary[5],
      JulyAmount: monthlySummary[6],
      AugustAmount: monthlySummary[7],
      SeptemberAmount: monthlySummary[8],
      OctoberAmount: monthlySummary[9],
      NovemberAmount: monthlySummary[10],
      DecemberAmount: monthlySummary[11],
    );
    myBarData.initializeBarData();

    return BarChart(BarChartData(
      maxY: 40.0,
      minY: 0,
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: getBottomTitles,
        )),
        topTitles: AxisTitles(
            sideTitles: SideTitles(
          showTitles: false,
        )),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      barGroups: myBarData.barData
          .map(
            (data) => BarChartGroupData(
              x: data.x,
              barRods: [
                BarChartRodData(toY: data.y, color: Colors.green, width: 20)
              ],
            ),
          )
          .toList(),
    ));
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.white,
    fontSize: 10,
  );

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = Text('Jan', style: style);
      break;
    case 1:
      text = Text('Feb', style: style);
      break;
    case 2:
      text = Text('Mar', style: style);
      break;
    case 3:
      text = Text('Apr', style: style);
      break;
    case 4:
      text = Text('May', style: style);
      break;
    case 5:
      text = Text('Jun', style: style);
      break;
    case 6:
      text = Text('Jul', style: style);
      break;
    case 7:
      text = Text('Aug', style: style);
      break;
    case 8:
      text = Text('Sep', style: style);
      break;
    case 9:
      text = Text('Oct', style: style);
      break;
    case 10:
      text = Text('Nov', style: style);
      break;
    case 11:
      text = Text('Dec', style: style);
      break;
    default:
      text = Text('Unknown', style: style);
      break;
  }

  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}

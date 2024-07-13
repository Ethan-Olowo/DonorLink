import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:string_capitalize/string_capitalize.dart';

buildChart(elementsMap, context) {
  List<BarChartGroupData> barGroups = [];
  int index = 0;
  elementsMap.entries.forEach((entry) {
    barGroups.add(
      BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
              toY: entry.value.toDouble(),
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.zero),
        ],
      ),
    );
    index++;
  });

  return AspectRatio(
    aspectRatio: 1.5,
    child: BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        //maxY: (elementsMap.values.reduce((var a, var b) => a > b ? a : b) * 1.2)
            //.toDouble(),
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String key = elementsMap.keys.elementAt(group.x.toInt());
              return BarTooltipItem(
                '${key.capitalize()}\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: rod.toY.toString(),
                    style: const TextStyle(
                      color: Colors.yellow,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                String key = elementsMap.keys.elementAt(value.toInt());
                return Text(key.capitalize(), style: const TextStyle(color: Colors.black, fontSize: 10));
              },
            ),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(width: 1),
            left: BorderSide(width: 1),
          ),
        ),
        barGroups: barGroups,
      ),
    ),
  );
}

import 'package:donorlink/Database/database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:string_capitalize/string_capitalize.dart';

class Chart extends StatefulWidget {
  final String type;
  final Database db = Database();
  Chart(this.type, {Key? key}) : super(key: key);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  Future<Map<String, int>> fetchData() async {
    return widget.db.getStats();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, int>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No ${widget.type.capitalize()} data available.');
        } else {
          Map<String, int> stats = snapshot.data!;

          List useful = [];
          if(widget.type == 'Users') useful =['donor','organisation','reviewer', 'admin'];
          if(widget.type == 'Interactions') useful =['donation','appointment','rating'];
          if(widget.type == 'Others') useful =['review','financial','approval',];
          Map<String, int> filteredData = Map.fromEntries(
            stats.entries.where((entry) => useful.contains(entry.key)),
          );

          List<BarChartGroupData> barGroups = [];
          int index = 0;
          for (var entry in filteredData.entries) {
            barGroups.add(
              BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: entry.value.toDouble(),
                    width: 40,
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.zero
                  ),
                ],
              ),
            );
            index++;
          }

          return AspectRatio(
            aspectRatio: 1.5,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: (filteredData.values.reduce((a, b) => a > b ? a : b) * 1.2).toDouble(),
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      String entryName = filteredData.keys.elementAt(group.x.toInt());
                      return BarTooltipItem(
                        '${entryName.capitalize()}s\n',
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
                        String entryName = filteredData.keys.elementAt(value.toInt());
                        return Text('${entryName.capitalize()}s ',
                            style: const TextStyle(color: Colors.black, fontSize: 10));
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
      },
    );
  }
}

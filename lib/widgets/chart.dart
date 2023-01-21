import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/models/spent.dart';
import 'package:myapp/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Spent> recentSpents;
  const Chart(this.recentSpents, {super.key});

  List<Map<String, Object>> get groupedSpentValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;
      for (var i = 0; i < recentSpents.length; i++) {
        if (recentSpents[i].date.day == weekDay.day &&
            recentSpents[i].date.month == weekDay.month &&
            recentSpents[i].date.year == weekDay.year) {
          totalSum += recentSpents[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedSpentValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedSpentValues.map((data) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                    (data['day'] as String),
                    (data['amount'] as double),
                    totalSpending == 0.0
                        ? 0.0
                        : (data['amount'] as double) / totalSpending),
              );
            }).toList()),
      ),
    );
  }
}

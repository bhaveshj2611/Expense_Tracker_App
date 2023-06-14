import 'package:expense_app/models/single_expense.dart';
import 'package:flutter/material.dart';

import 'package:expense_app/widgets/chart/chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<SingleExpense> expenses;

  List<ExpenseBucket> getbuckets() {
    return [
      ExpenseBucket.forCategory(expenses, Category.food),
      ExpenseBucket.forCategory(expenses, Category.leisure),
      ExpenseBucket.forCategory(expenses, Category.travel),
      ExpenseBucket.forCategory(expenses, Category.work),
    ];
  }

  double getmaxTotalExpense() {
    double maxTotalExpense = 0;

    for (final bucket in getbuckets()) {
      if (bucket.getTotalExpenses() > maxTotalExpense) {
        maxTotalExpense = bucket.getTotalExpenses();
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in getbuckets()) // alternative to map()
                  ChartBar(
                    fill: bucket.getTotalExpenses() == 0
                        ? 0
                        : bucket.getTotalExpenses() / getmaxTotalExpense(),
                  )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: getbuckets()
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        categoryIcons[bucket.category],
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}

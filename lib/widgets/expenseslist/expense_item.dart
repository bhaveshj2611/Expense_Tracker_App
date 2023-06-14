import 'package:expense_app/models/single_expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(
      {super.key, required this.expense, required this.onEditExpense});

  final void Function() onEditExpense;

  final SingleExpense expense;
  Widget build(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(expense.title,
                    style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text('₹ ${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(expense.getFormattedDate()),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

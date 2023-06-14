import 'package:expense_app/models/single_expense.dart';
import 'package:expense_app/widgets/expenseslist/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key,
      required this.expenses,
      required this.onRemove,
      required this.onEdit});

  final void Function(SingleExpense expense) onRemove;
  final void Function() onEdit;

  final List<SingleExpense> expenses;

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
          key: ValueKey(expenses[index]),
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.6),
            margin: Theme.of(context).cardTheme.margin,
          ),
          onDismissed: (direction) => onRemove(expenses[index]),
          direction: DismissDirection.endToStart,
          child: ExpenseItem(onEditExpense: onEdit, expense: expenses[index])),
    );
  }
}

import 'package:expense_app/widgets/add_expense.dart';
import 'package:expense_app/widgets/chart/chart.dart';
import 'package:expense_app/widgets/expenseslist/expenses_list.dart';
import 'package:expense_app/models/single_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<SingleExpense> _registeredExpenses = [
    SingleExpense(
      title: 'Flutter Course',
      amount: 400,
      category: Category.work,
      date: DateTime.now(),
    ),
    SingleExpense(
      title: 'Mcdonalds',
      amount: 200,
      category: Category.food,
      date: DateTime.now(),
    )
  ];

  void _openAddExpense() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => AddExpense(addtoExpense: addNewExpense));
  }

  void addNewExpense(SingleExpense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void editExpense() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) => AddExpense(addtoExpense: addNewExpense));
  }

  void removeExpense(SingleExpense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Expense removed'),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            })));
  }

  @override
  Widget build(context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text(
        'No Expenses here, try adding some',
      ),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemove: removeExpense,
        onEdit: editExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Expense-X'), actions: [
        IconButton(onPressed: _openAddExpense, icon: const Icon(Icons.add))
      ]),
      body: width < 600
          ? Column(children: [
              Chart(expenses: _registeredExpenses),
              Expanded(child: mainContent),
            ])
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}

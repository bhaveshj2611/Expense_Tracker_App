import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category {
  food,
  leisure,
  work,
  travel,
}

const categoryIcons = {
  Category.food: Icons.lunch_dining_rounded,
  Category.leisure: Icons.paragliding_outlined,
  Category.work: Icons.work,
  Category.travel: Icons.airplanemode_active,
};

class SingleExpense {
  SingleExpense({
    required this.amount,
    required this.date,
    required this.title,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final DateTime date;
  final double amount;
  final Category category;

  getFormattedDate() {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.expenses, required this.category});

  ExpenseBucket.forCategory(List<SingleExpense> allExpenses, this.category)
      : expenses = allExpenses
            .where(
              (exp) => exp.category == category,
            )
            .toList();
  final List<SingleExpense> expenses;
  final Category category;

  double getTotalExpenses() {
    double sum = 0;
    for (final exp in expenses) {
      sum += exp.amount;
    }

    return sum;
  }
}

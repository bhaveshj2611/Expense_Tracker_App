import 'package:flutter/material.dart';
import 'package:expense_app/models/single_expense.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class AddExpense extends StatefulWidget {
  const AddExpense({required this.addtoExpense, super.key});

  final void Function(SingleExpense expense) addtoExpense;

  @override
  State<AddExpense> createState() {
    return _AddExpenseState();
  }
}

class _AddExpenseState extends State<AddExpense> {
  final savingTitle = TextEditingController();
  final savingAmount = TextEditingController();
  DateTime? selectedDate;
  Category selectedCategory = Category.food;

  void displayDatePicker() async {
    final now = DateTime.now();
    final fDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context, initialDate: now, firstDate: fDate, lastDate: now);
    setState(() {
      selectedDate = pickedDate;
    });
  }

  void submitExpense() {
    final enteredAmount = double.tryParse(savingAmount.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (savingTitle.text.trim().isEmpty ||
        amountIsInvalid ||
        selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Please Enter valid data in fields'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Close'))
          ],
        ),
      );
      return;
    }
    widget.addtoExpense(SingleExpense(
        amount: enteredAmount,
        date: selectedDate!,
        title: savingTitle.text,
        category: selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    savingTitle;
    savingAmount;
    super.dispose();
  }

  @override
  Widget build(context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            maxLength: 30,
                            controller: savingTitle,
                            decoration: const InputDecoration(
                              label: Text('Enter Title'),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: savingAmount,
                            decoration: const InputDecoration(
                              prefixText: '₹',
                              label: Text('Enter Amount'),
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      maxLength: 30,
                      controller: savingTitle,
                      decoration: const InputDecoration(
                        label: Text('Enter Title'),
                      ),
                    ),
                  if (width >= 600)
                    Row(
                      children: [
                        DropdownButton(
                            value: selectedCategory,
                            items: Category.values
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name.toUpperCase()),
                                  ),
                                )
                                .toList(),
                            iconEnabledColor: Colors.deepPurple,
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              setState(() {
                                selectedCategory = value;
                              });
                            }),
                        Spacer(),
                        IconButton(
                            onPressed: displayDatePicker,
                            icon: const Icon(Icons.calendar_month)),
                        Text(
                          selectedDate == null
                              ? 'Select Date'
                              : formatter.format(selectedDate!),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: savingAmount,
                            decoration: const InputDecoration(
                              prefixText: '₹',
                              label: Text('Enter Amount'),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: displayDatePicker,
                                  icon: const Icon(Icons.calendar_month)),
                              Text(
                                selectedDate == null
                                    ? 'Select Date'
                                    : formatter.format(selectedDate!),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (width >= 600)
                    Row(
                      children: [
                        Spacer(),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel ')),
                        ElevatedButton(
                            onPressed: submitExpense,
                            child: const Text('Save Expense'))
                      ],
                    )
                  else
                    Row(
                      children: [
                        DropdownButton(
                            value: selectedCategory,
                            items: Category.values
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name.toUpperCase()),
                                  ),
                                )
                                .toList(),
                            iconEnabledColor: Colors.deepPurple,
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              setState(() {
                                selectedCategory = value;
                              });
                            }),
                        Spacer(),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel ')),
                        ElevatedButton(
                            onPressed: submitExpense,
                            child: const Text('Save Expense'))
                      ],
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

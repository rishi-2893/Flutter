import 'package:flutter/material.dart';
import 'package:section_5/new_expense.dart';
import 'package:section_5/widgets/chart/chart.dart';
import 'package:section_5/widgets/expenses_list/expenses_list.dart';
import 'package:section_5/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    // alternative to a menu or a dialog and prevents the
    // user from interacting with the rest of the app
    // NOTE: "context" - information object of _ExpensesState class
    // and "ctx" - information object of showModalBottomSheet object
    // both are passed automatically by flutter
    showModalBottomSheet(
      isScrollControlled: true, // Cover whole screen
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    // Clear existing snackbar (happens when deleting consecutively)
    ScaffoldMessenger.of(context).clearSnackBars();
    // Show undo button after deleting
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: (){
            setState(() {
              // we have to insert to the same position
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
          ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No Expenses to show, Add now!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          // You need to wrap inside Expanded widget due to some
          // technical reasons
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}

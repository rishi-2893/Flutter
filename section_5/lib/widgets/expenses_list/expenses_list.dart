import 'package:flutter/material.dart';
import 'package:section_5/models/expense.dart';
import 'package:section_5/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final void Function(Expense expense) onRemoveExpense;

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    // DO NOT USE COLUMN HERE! -- Performance hit
    return ListView.builder(
      itemCount: expenses.length,
      // ctx, index provided by flutter
      // index goes from 0 till itemCount
      // Widgets are created on demand
      itemBuilder: (ctx, index) => Dismissible(
        // used to remove by swiping
        // key is used to identify the widget to remove
        key: ValueKey([expenses[index]]),
        // Using color from the color scheme
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        onDismissed: (direction) {
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}

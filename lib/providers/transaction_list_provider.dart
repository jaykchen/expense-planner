import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/transaction.dart';

final transactionListProvider =
    StateNotifierProvider<TransactionList, List<Transaction>>((ref) {
  return TransactionList([
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
  ]);
});

class TransactionList extends StateNotifier<List<Transaction>> {
  TransactionList([List<Transaction>? initialTransactions])
      : super(initialTransactions ?? []);

  void add(String enteredTitle, double enteredAmount, DateTime _selectedDate) {
    state = [
      ...state,
      Transaction(
        id: DateTime.now().toString(),
        title: enteredTitle,
        amount: enteredAmount,
        date: _selectedDate,
      ),
    ];
  }

// void toggle(String id) {
//   state = [
//     for (final todo in state)
//       if (todo.id == id)
//         Todo(
//           id: todo.id,
//           completed: !todo.completed,
//           description: todo.description,
//         )
//       else
//         todo,
//   ];
// }
//
// void edit({required String id, required String description}) {
//   state = [
//     for (final todo in state)
//       if (todo.id == id)
//         Todo(
//           id: todo.id,
//           completed: todo.completed,
//           description: description,
//         )
//       else
//         todo,
//   ];
// }
//
  void remove(int index) {
    state = state.where((transact) => transact != state[index]).toList();
  }
}

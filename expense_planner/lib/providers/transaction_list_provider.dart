import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/transaction.dart';

class TransactionList extends StateNotifier<List<Transaction?>> {

  List<Transaction?> lis =[];

  TransactionList() : super([]);

  void add(Transaction transact) {
    if (lis != null) {
      lis.add(transact);

    } else {
      lis = [transact];
    }
  }

  void _deleteTransaction(String id) {
    lis.removeWhere((tx) => tx!.id == id);
  }

  List<Transaction?> get _recentTransactions {
    return lis.where((tx) {
      return tx!.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }
}

// void _addNewTransaction(String txTitle, double txAmount,
//     DateTime chosenDate) {
//   final newTx = Transaction(
//     title: txTitle,
//     amount: txAmount,
//     date: chosenDate,
//     id: DateTime.now().toString(),
//   );
//
//   setState(() {
//     _userTransactions.add(newTx);
//   });
// }

final transactionListProvider = StateNotifierProvider<TransactionList,
    List<Transaction?>>((ref) => TransactionList());


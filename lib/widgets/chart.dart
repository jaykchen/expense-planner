import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/transaction_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final groupedTransactionValuesProvider =
    Provider<List<Map<String, dynamic>>>((ref) {
  final recentTransactions = ref.watch(transactionListProvider);

  return List.generate(7, (index) {
    final weekDay = DateTime.now().subtract(
      Duration(days: index),
    );
    var totalSum = 0.0;

    for (var i = 0; i < recentTransactions.length; i++) {
      if (recentTransactions[i].date.day == weekDay.day &&
          recentTransactions[i].date.month == weekDay.month &&
          recentTransactions[i].date.year == weekDay.year) {
        totalSum += recentTransactions[i].amount;
      }
    }

    return {
      'day': DateFormat.E().format(weekDay).substring(0, 1),
      'amount': totalSum,
    };
  }).reversed.toList();
});

final totalSpendingProvider = Provider<num>((ref) {
  final groupedTransactionValues = ref.watch(groupedTransactionValuesProvider);
  var sum = 0;
  for (var item in groupedTransactionValues) {
    sum + (item['amount'] as num);
  };
  return sum;
});

class Chart extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final groupedTransactionValues =
        ref.watch(groupedTransactionValuesProvider);
    final totalSpending = ref.watch(totalSpendingProvider);

    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'] as String?,
                data['amount'] as double?,
                totalSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ChartBar extends StatelessWidget {
  final String? label;
  final double? spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          child: FittedBox(
            child: Text('\$${spendingAmount!.toStringAsFixed(0)}'),
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(label!),
      ],
    );
  }
}

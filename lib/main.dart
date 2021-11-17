import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      // theme: ThemeData(
      //     primarySwatch: Colors.purple,
      //     accentColor: Colors.amber,
      //     // errorColor: Colors.red,
      //     fontFamily: 'Quicksand',
      //     textTheme: ThemeData.light().textTheme.copyWith(
      //           title: TextStyle(
      //             fontFamily: 'OpenSans',
      //             fontWeight: FontWeight.bold,
      //             fontSize: 18,
      //           ),
      //           button: TextStyle(color: Colors.white),
      //         ),
      //     appBarTheme: AppBarTheme(
      //       textTheme: ThemeData.light().textTheme.copyWith(
      //             title: TextStyle(
      //               fontFamily: 'OpenSans',
      //               fontSize: 20,
      //               fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //     )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Expenses',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => (BuildContext ctx) {
              showModalBottomSheet(
                context: ctx,
                builder: (_) {
                  return GestureDetector(
                    onTap: () {},
                    child: NewTransactionWidget(),
                    behavior: HitTestBehavior.opaque,
                  );
                },
              );
            }(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(),
            TransactionListWidget(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => (BuildContext ctx) {
          showModalBottomSheet(
            context: ctx,
            builder: (_) {
              return GestureDetector(
                onTap: () {},
                child: NewTransactionWidget(),
                behavior: HitTestBehavior.opaque,
              );
            },
          );
        }(context),
      ),
    );
  }
}

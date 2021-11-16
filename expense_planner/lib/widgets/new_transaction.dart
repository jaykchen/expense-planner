import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/transaction_list_provider.dart';
import '../models/transaction.dart';

class NewTransactionWidget extends ConsumerStatefulWidget {
  final Function addTx;

  NewTransactionWidget(this.addTx);

  @override
  ConsumerState createState() => _NewTransactionWidgetState();
}

class _NewTransactionWidgetState extends ConsumerState<NewTransactionWidget> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;


  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    final lis = ref.watch(transactionListProvider);
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen!'
                          : 'Picked Date: ${DateFormat.yMd().format(
                          _selectedDate!)}',
                    ),
                  ),
                  FlatButton(
                    // textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _presentDatePicker,
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text('Add Transaction'),
              // color: Theme.of(context).primaryColor,
              // textColor: Theme.of(context).textTheme.button.color,
              onPressed: () {
                if (_amountController.text.isEmpty) {
                  return;
                }
                final enteredTitle = _titleController.text;
                final enteredAmount = double.parse(_amountController.text);

                if (enteredTitle.isEmpty || enteredAmount <= 0 ||
                    _selectedDate == null) {
                  return;
                }
                lis.add(
                    Transaction(
                      id: DateTime.now().toString(),
                      title: enteredTitle,
                      amount: enteredAmount,
                      date: _selectedDate!,
                    ));
                widget.addTx(
                  enteredTitle,
                  enteredAmount,
                  _selectedDate,
                );

                Navigator.of(context).pop();
              }
              ,
            ),
          ],
        ),
      ),
    );
  }
}

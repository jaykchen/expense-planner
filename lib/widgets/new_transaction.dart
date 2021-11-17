import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/transaction_list_provider.dart';

class NewTransactionWidget extends ConsumerStatefulWidget {
  @override
  ConsumerState createState() => _NewTransactionWidgetState();
}

class _NewTransactionWidgetState extends ConsumerState<NewTransactionWidget> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: HookConsumer(
          builder: (context, ref, child) {

            return Column(
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
                              : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
                        ),
                      ),
                      TextButton(
                        // textColor: Theme.of(context).primaryColor,
                        child: Text(
                          'Choose Date',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () => showDatePicker(
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
                        }),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  child: Text('Add Transaction'),
                  // color: Theme.of(context).primaryColor,
                  // textColor: Theme.of(context).textTheme.button.color,
                  onPressed: () {
                    if (_amountController.text.isEmpty) {
                      return;
                    }
                    final enteredTitle = _titleController.text;
                    final enteredAmount = double.parse(_amountController.text);

                    if (enteredTitle.isEmpty ||
                        enteredAmount <= 0 ||
                        _selectedDate == null) {
                      return;
                    }
                    ref.read(transactionListProvider.notifier).add(
                      enteredTitle,
                      enteredAmount,
                      _selectedDate!,
                    );
                    // widget.addTx(
                    //   enteredTitle,
                    //   enteredAmount,
                    //   _selectedDate,
                    // );
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

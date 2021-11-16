import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(ProviderScope(
    child: MaterialApp(
        // Disable the debug flag
        debugShowCheckedModeBanner: false,
        // Home
        home: MyHome()),
  ));
}

class Pref {

  Pref([required this.pref], {this.counter, this.key});
  SharedPreferences  pref = SharedPreferences.getInstance() as SharedPreferences;

  int counter = 0;
  var key = "counter";

  void _loadSavedData(SharedPreferences pref) async {
    counter = (pref.getInt(key) ?? 0);
  }

  void _onIncrementHit(SharedPreferences pref) async {
    counter = (pref.getInt(key) ?? 0) + 1;

    pref.setInt(key, counter);
  }

  void _onDecrementHit(SharedPreferences pref) async {
    counter = (pref.getInt(key) ?? 0) - 1;
    pref.setInt(key, counter);
  }

}

class MyHome extends StatelessWidget {
  var nameOfApp = "Persist Key Value";


  @override
  void initState() {
    _loadSavedData(pref as SharedPreferences);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: AppBar(
        // Title
        title: Text(nameOfApp),
      ),
      // Body
      body: Container(
        // Center the content
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '${counter}',
                textScaleFactor: 10.0,
              ),
              Padding(padding: EdgeInsets.all(10.0)),
              RaisedButton(
                  onPressed: () => _onIncrementHit(pref as SharedPreferences),
                  child: Text('Increment Counter')),
              Padding(padding: EdgeInsets.all(10.0)),
              RaisedButton(
                  onPressed: () => _onDecrementHit(pref as SharedPreferences),
                  child: Text('Decrement Counter')),
            ],
          ),
        ),
      ),
    );
  }
}

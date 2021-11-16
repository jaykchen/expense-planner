import 'dart:convert';
import 'package:riverpod/riverpod.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';

Future<void> main() async {
  runApp(ProviderScope(
    child: MaterialApp(
      home: MyApp(),
    ),
  ));
}

class Reader {
  Future<String> readJson() async {
    // String holder = '''[{
    //   "name": "Changed",
    // "height": "167",
    // "mass": "75",
    // "hair_color": "n/a",
    // "skin_color": "gold",
    // "eye_color": "yellow",
    // "birth_year": "112BBY",
    // "gender": "n/a"
    // },{
    //   "name": "Changed",
    // "height": "167",
    // "mass": "75",
    // "hair_color": "n/a",
    // "skin_color": "gold",
    // "eye_color": "yellow",
    // "birth_year": "112BBY",
    // "gender": "n/a"
    // }]''';
    late String contents;

    try {
      var path = await Directory(
              '/home/jaykchen/AndroidStudioProjects/flutter-examples/load_local_json/data_repo');
      var file = File('${path.path}/starwars_data.json');
      contents = await file.readAsString();
    } catch (e) {
      print(e);
    }
    return contents;
  }
}

class ReaderProvider extends StateNotifier<Future<String>> {
  ReaderProvider() : super('' as Future<String>);

  Future<String> getRaw() {
    return Reader().readJson();
  }
}

final jsonProvider = FutureProvider<Future<String>>(
    (ref) => Reader().readJson());
// final jsonProvider = FutureProvider((ref) async {
//   final jsonClient = ref.watch(readerProvider);
//   return jsonClient;
// });

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Load local JSON file"),
        ),
        body: Container(
          child: Center(
            // Use future builder and DefaultAssetBundle to load the local JSON file
            child: FutureBuilder(
                future: Reader().readJson(),
                builder: (context, snapshot) {
                  // Decode the JSON
                  var new_data = json.decode(snapshot.data.toString());

                  return ListView.builder(
                    // Build the ListView
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text("Name: " + new_data[index]['name']),
                            Text("Height: " + new_data[index]['height']),
                            Text("Mass: " + new_data[index]['mass']),
                            Text(
                                "Hair Color: " + new_data[index]['hair_color']),
                            Text(
                                "Skin Color: " + new_data[index]['skin_color']),
                            Text(
                                "Eye Color: " + new_data[index]['eye_color']),
                            Text(
                                "Birth Year: " + new_data[index]['birth_year']),
                            Text("Gender: " + new_data[index]['gender'])
                          ],
                        ),
                      );
                    },
                    itemCount: new_data == null ? 0 : new_data.length,
                  );
                }),
          ),
        ));
  }
}
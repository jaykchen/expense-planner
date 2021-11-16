import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// void main() {
//   runApp(ProviderScope(
//       child: MaterialApp(
//     home: Scaffold(
//       appBar: AppBar(
//         title: Text("Retrieve JSON Data via HTTP GET"),
//       ),
//       body: MyGetHttpData(),
//     ),
//   )));
// }

final queryProvider = FutureProvider.autoDispose<Future<List<String>>>((ref) async {
  final Uri url = Uri.https("swapi.dev", "/api/people");
  Future<List<String>> data = [] as Future<List<String>>;

  Future<List<String>> run() async {
    var response = await http.get(url, headers: {"Accept": "application/json"});

    var dataConvertedToJSON = json.decode(response.body);
    print(dataConvertedToJSON);
    try {
      data =  List<String>.from(dataConvertedToJSON['results']) as Future<List<String>>;
      print(data);
    } catch (e) {}
    return data;
  }

  Future<List<String>> res = run();
  return res;
});

// class MyGetHttpData extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final List<String>? dat = ref.watch(queryProvider).value as List<String>;
// // print(dat);
//     return dat == null
//         ? CircularProgressIndicator()
//         : ListView.builder(
//             itemCount: dat.length,
//             itemBuilder: (BuildContext context, int index) {
//               return Container(
//                 child: Center(
//                     child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: <Widget>[
//                     Card(
//                       child: Container(
//                         child: Text(
//                           dat[index],
//                           // dat[index]['name'],
//                           style: TextStyle(
//                               fontSize: 20.0, color: Colors.lightBlueAccent),
//                         ),
//                         padding: const EdgeInsets.all(15.0),
//                       ),
//                     )
//                   ],
//                 )),
//               );
//             });
//   }
// }


void main() {
  runApp(MaterialApp(
    home: MyGetHttpData(),
  ));
}

// Create a stateful widget
class MyGetHttpData extends StatefulWidget {
  @override
  MyGetHttpDataState createState() => MyGetHttpDataState();
}

// Create the state for our stateful widget
class MyGetHttpDataState extends State<MyGetHttpData> {
  final Uri url = Uri.https("swapi.dev", "/api/people");
 late List data;

  // Function to get the JSON data
  Future<String> getJSONData() async {
    var response = await http.get(
      // Encode the url
        url,
        // Only accept JSON response
        headers: {"Accept": "application/json"});

    // Logs the response body to the console
    print(response.body);

    // To modify the state of the app, use this method
    setState(() {
      // Get the JSON data
      var dataConvertedToJSON = json.decode(response.body);
      try {
          // Extract the required part and assign it to the global variable named data
          data = dataConvertedToJSON['results'];
      } catch (e) {
        print(dataConvertedToJSON.statusCode);
      }
    });

    return "Successfull";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Retrieve JSON Data via HTTP GET"),
      ),
      // Create a Listview and load the data when available
      body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Center(
                  child: Column(
                    // Stretch the cards in horizontal axis
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Card(
                        child: Container(
                          child: Text(
                            // Read the name field value and set it in the Text widget
                            data[index]['name'],
                            // set some style to text
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.lightBlueAccent),
                          ),
                          // added padding
                          padding: const EdgeInsets.all(15.0),
                        ),
                      )
                    ],
                  )),
            );
          }),
    );
  }

  @override
  void initState() {
    super.initState();

    // Call the getJSONData() method when the app initializes
    this.getJSONData();
  }
}
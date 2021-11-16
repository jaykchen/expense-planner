import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() =>
    runApp(ProviderScope(child: new MaterialApp(home: PositionedTiles())));

// List<Widget> tiles = [
//   Padding(
//     key: UniqueKey(),
//     padding: const EdgeInsets.all(8.0),
//     child: StatefulColorfulTile(),
//   ),
//   Padding(
//     key: UniqueKey(),
//     padding: const EdgeInsets.all(8.0),
//     child: StatefulColorfulTile(),
//   ),
// ];

List<Widget> tiles = [ColorfulTileState(), ColorfulTileState()];

class InnerProvider extends StateNotifier<List<Widget>> {
  InnerProvider() : super(tiles);

  void toggle() {
    // state.removeAt(0);
    this.state.insert(1, this.state.removeAt(0));
    print(state.length);
  }
}

final tileProvider = StateNotifierProvider<InnerProvider, List<Widget>>((ref) {
  return InnerProvider();
});


class ColorfulTileState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Color myColor = UniqueColorGenerator.getColor();
    print("tile rebuilt");
    return Container(
        key: UniqueKey(),
        color: myColor,
        child: Padding(
          padding: EdgeInsets.all(70.0),
        ));
  }
}


class UniqueColorGenerator {
  static List colorOptions = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.indigo,
    Colors.amber,
    Colors.black,
  ];
  static Random random = new Random();

  static Color getColor() {
    if (colorOptions.length > 0) {
      return colorOptions.removeAt(random.nextInt(colorOptions.length));
    } else {
      return Color.fromARGB(random.nextInt(256), random.nextInt(256),
          random.nextInt(256), random.nextInt(256));
    }
  }
}

class PositionedTiles extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("tiles swapped or not?");
    final til = ref.watch(tileProvider);
    return Scaffold(
      body: Row(
          key: UniqueKey(),
          children: til),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.sentiment_very_satisfied),
        onPressed: () => ref.read(tileProvider.notifier).toggle(),
      ),
    );
  }
}


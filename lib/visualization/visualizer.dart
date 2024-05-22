import 'dart:math';

import 'package:flutter/material.dart';
import 'package:visualization/algorithm/binarySearch.dart';
import 'package:visualization/visualization/gridList.dart';
import 'package:visualization/visualization/inkWellWidget.dart';

class Visualizer extends StatefulWidget {
  @override
  _VisualizerState createState() => _VisualizerState();
}

class _VisualizerState extends State<Visualizer> {
  BinarySearch _binarySearch = BinarySearch();
  int binarySearchResult = -1;
  Random randomGenerator = Random();
  int tempRanNum = 0;
  Set<int> arraySet = Set.from(List.generate(30, (index) => -1));

  @override
  void initState() {
    binarySearchResult = -1;
    arraySet = Set.from(
        List.generate(30, (index) => randomGenerator.nextInt(100)).toList()
          ..sort());

    // tempRanNum = randomGenerator.nextInt(100);
    // binarySearchResult = _binarySearch.binarySearch(
    //     arraySet.toList(), tempRanNum, 0, arraySet.length - 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    int left = 0;
    int right = arraySet.length - 1;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'enter custom search values',
            icon: Icon(Icons.add),
            onPressed: () {},
          )
        ],
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ListTile(
          leading: Text(
            binarySearchResult == -1
                ? 'Searching for: $tempRanNum'
                : '$tempRanNum was found',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
          ),
        ),
        Material(
          elevation: 48,
          shadowColor: Colors.grey,
          child: AnimatedContainer(
            curve: Curves.bounceIn,
            duration: Duration(milliseconds: 250),
            height: size.height * 0.40,
            child: GridListBuilder(
                arraySet: arraySet,
                binarySearchResult: binarySearchResult,
                size: size),
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWellWidget(
                text: 'Search',
                onTap: () {
                  setState(() {
                    tempRanNum = randomGenerator.nextInt(100);
                    binarySearchResult = _binarySearch.binarySearch(
                        arraySet.toList(), tempRanNum, left, right);
                  });
                }),
            InkWellWidget(
                text: 'Generate Array',
                onTap: () {
                  setState(() {
                    arraySet = Set.from(List.generate(
                        30, (index) => randomGenerator.nextInt(100)).toList()
                      ..sort());
                  });
                }),
            InkWellWidget(
                text: 'Reset',
                onTap: () {
                  setState(() {
                    tempRanNum = 0;
                    binarySearchResult = -1;
                    BinarySearch.leftPointer = -1;
                    BinarySearch.rightPointer = -1;
                    arraySet.clear();
                  });
                }),
          ],
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 32,
              shadowColor: Colors.purple,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade900),
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Left Pointer: ${BinarySearch.leftPointer}\n',
                            style: TextStyle(fontSize: 16)),
                        Text('Right Pointer: ${BinarySearch.rightPointer}\n',
                            style: TextStyle(fontSize: 16)),
                        Text(
                            'MidPoint: ${(BinarySearch.leftPointer + BinarySearch.rightPointer) ~/ 2}\n',
                            style: TextStyle(fontSize: 16)),
                        Text('Return -1 if L > R : value not found.',
                            style: TextStyle(fontSize: 16)),
                      ]),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

Color changeTextColor(int index, int resultValue) {
  if (index == resultValue) {
    // Highlight the index where the search value was found.
    return Colors.black;
  }
  // Default color for other indices.
  return Colors.white;
}

String switchPointer(int index, int resultValue) {
  if (index == BinarySearch.leftPointer && index != resultValue) {
    // Display the left pointer [L].
    return 'L';
  } else if (index == BinarySearch.rightPointer && index != resultValue) {
    // Display the right pointer [R].
    return 'R';
  } else if (index == resultValue && index != BinarySearch.rightPointer) {
    // Indicate the midpoint [M].
    return 'M';
  } else if (index == BinarySearch.leftPointer &&
      index == BinarySearch.rightPointer &&
      index == resultValue) {
    // Indicate that all pointers are the same [LR].
    return 'LR';
  }
  // Default is to display nothing.
  return '';
}

//The following method is simply for customization of the pointer values,
Color switchPointerColor(int index, int resultValue) {
  if (index == BinarySearch.leftPointer) {
    // Color for the left pointer.
    return Colors.black;
  } else if (index == BinarySearch.rightPointer) {
    // Color for the right pointer.
    return Colors.red;
  } else if (index == resultValue) {
    // Color for the result index.
    return Colors.green;
  }
  // Default color for other indices.
  return Colors.purpleAccent;
}
//The following method is simply for customization for the container background color,

Color switchDefaultColor(int index, int resultValue) {
  switch (resultValue) {
    case -1:
      // Value not found in the array.
      return Colors.blueGrey;
    default:
      if (index > resultValue) {
        // Indices to the right of the result will be blue.
        return Colors.blue;
      } else if (index < resultValue) {
        // Indices to the left of the result will be black.
        return Colors.black;
      } else {
        // Highlight the index of the result.
        return Colors.amber;
      }
  }
}

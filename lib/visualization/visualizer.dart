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
  int binarySearchResult = 0;
  Random randomGenerator = Random();
  int tempRanNum = 0;
  Set<int> arraySet = Set.from(List.generate(30, (index) => -1));

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    int left = 0;
    int right = arraySet.length - 1;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListTile(
          trailing: CircleAvatar(
            radius: 24,
            backgroundColor:
                binarySearchResult == -1 ? Colors.blueGrey : Colors.amber,
            child: Text(
              '$binarySearchResult',
              style: TextStyle(
                  color:
                      binarySearchResult == -1 ? Colors.white : Colors.black),
            ),
          ),
          leading: Text(
            binarySearchResult == -1
                ? 'Searching for: $tempRanNum'
                : '$tempRanNum was found',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
          ),
        ),
        Container(
          height: size.height * 0.40,
          child: GridListBuilder(
              arraySet: arraySet,
              binarySearchResult: binarySearchResult,
              size: size),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Align(
            alignment: Alignment.topLeft,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                    tempRanNum = -1;
                    binarySearchResult = -1;
                    BinarySearch.leftPointer = -1;
                    BinarySearch.rightPointer = -1;
                    arraySet.clear();
                  });
                }),
          ],
        ),
      ],
    );
  }
}

Color changeTextColor(int index, int resultValue) {
  if (index > resultValue) {
    //change the upperbounds of the array text color
    return Colors.white;
  } else if (index < resultValue) {
    //change the lowerbounds of the array text color
    return Colors.white;
  } else if (index == resultValue) {
    //highlight the index where the search value was found.
    return Colors.black;
  }
  return Colors.white;
}

String switchPointer(int index, int resultValue) {
  //the index value is from the gridView itself, consider that our control point
  //the resultValue is the value thats returned from the binarySearch impl

  if (index == BinarySearch.leftPointer && index != resultValue) {
    // we only want to display the leftpointer[L],only if the control point [index]
    //is equal to the leftPointer[L] in the BinarySearch class itself.
    //doing so will only display the leftPointer[L] that is appropriate to (midPoint + 1).
    //otherwise if we compare it to the resultValue all numbers to the left will have a leftPointer[L].

    return 'L ';
  } else if (index == BinarySearch.rightPointer && index != resultValue) {
    //our control point [index] is now compared to the rightPointer[R] in the BinarySearch class [mid - 1]
    //everything is the same as above, only this time we're checking for the rightPointer[R]
    return 'R ';
  } else if (index == resultValue && index != BinarySearch.rightPointer) {
    //if the control point and resultValue are the same we've found our value
    return 'M ';
  } else if (index == BinarySearch.rightPointer &&
      index == BinarySearch.leftPointer &&
      index == (resultValue)) {
    //return LR when all the L, R , M pointers are the same.
    return "LR ";
  }

  //leave as is to only display L,M,R pointers,whatever character is passed here will be displayed
  //at each index where condition isnt met above.
  return '';
}

//The following method is simply for customization for the pointer values,
//refer to the comments above to understand the logic lines 190-209.
Color switchPointerColor(int index, int resultValue) {
  if (index == BinarySearch.leftPointer) {
    return Colors.black;
  } else if (index == BinarySearch.rightPointer) {
    return Colors.red;
  } else if (index == resultValue) {
    return Colors.green[800];
  }
  return Colors.purpleAccent;
}

//The following method is simply for customization for the container background color,
//refer to the comments above to understand the logic lines 190-209.
Color switchDefaultColor(int index, int resultValue) {
  if (resultValue == -1) {
    // if value we're searching for doesn't exist in our array.
    return Colors.blueGrey;
  } else if (index > resultValue) {
    //the upperbounds of the array will be red
    //the indices to the right of our result/midpoint values is greater.
    return Colors.blue;
  } else if (index < resultValue) {
    //the lowerbounds of the array will be black
    //the indices to the left of our result/midpoint values is smaller.
    return Colors.black;
  } else if (index == resultValue) {
    //highlight the index and value in our array if it exists.
    return Colors.amber;
  }
  //does nothing.
  return Colors.transparent;
}

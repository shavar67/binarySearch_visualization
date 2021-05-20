import 'dart:math';

import 'package:flutter/material.dart';
import 'package:visualization/binarySearch.dart';

class Visualizer extends StatefulWidget {
  @override
  _VisualizerState createState() => _VisualizerState();
}

class _VisualizerState extends State<Visualizer> {
  BinarySearch _binarySearch = BinarySearch();
  List<num> numArray = [
    0,
    1,
    5,
    6,
    9,
    10,
    15,
    18,
    19,
    21,
    25,
    29,
    33,
    45,
    56,
    67,
    72,
    75,
    87,
    91,
    93,
    98,
    99,
    100,
  ];
  int binarySerachResult = 0;
  Random randomGenerator = Random();
  int tempRanNum = 0;

  @override
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    int left = 0;
    int right = numArray.length - 1;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListTile(
          trailing: CircleAvatar(
            radius: 24,
            backgroundColor:
                binarySerachResult == -1 ? Colors.blueGrey : Colors.amber,
            child: Text(
              '$binarySerachResult',
              style: TextStyle(
                  color:
                      binarySerachResult == -1 ? Colors.white : Colors.black),
            ),
          ),
          leading: Text(
            'Searching for: $tempRanNum',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
          ),
        ),
        Container(
          height: size.height * 0.35,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: numArray.length != null ? numArray.length : 0,
            itemBuilder: (context, index) {
              return Padding(
                padding: index == binarySerachResult
                    ? const EdgeInsets.all(0)
                    : const EdgeInsets.all(6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      switchPointer(index, binarySerachResult),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: switchPointerColor(index, binarySerachResult)),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          width: size.width * 0.10,
                          height: size.height * 0.04,
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                              border: index == binarySerachResult
                                  ? Border.all(color: Colors.white, width: 3)
                                  : Border.all(
                                      width: 0, color: Colors.transparent),
                              color:
                                  switchDefaultColor(index, binarySerachResult),
                              borderRadius: index == binarySerachResult
                                  ? BorderRadius.circular(8)
                                  : BorderRadius.circular(0)),
                          child: Center(
                              child: Text(
                            '${numArray[index]}',
                            style: TextStyle(
                                color:
                                    changeTextColor(index, binarySerachResult),
                                fontSize:
                                    index == binarySerachResult ? 14 : 10),
                          )),
                        ),
                        Text('$index',
                            style: TextStyle(
                                color: index == binarySerachResult
                                    ? Colors.black
                                    : Colors.white))
                      ],
                    ),
                  ],
                ),
              );
            },
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
          ),
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
                  'MidPoint: ${(BinarySearch.leftPointer + BinarySearch.rightPointer) ~/ 2.floor()}\n',
                  style: TextStyle(fontSize: 16)),
              Text('Return -1 if L > R, value not found.',
                  style: TextStyle(fontSize: 16)),
            ]),
          ),
        ),
        SizedBox(height: 20),
        InkWell(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Visualize',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            onTap: () {
              setState(() {
                tempRanNum = randomGenerator.nextInt(101);
                binarySerachResult = _binarySearch.binarySearch(
                    numArray, tempRanNum, left, right);
              });
            }),
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

  if (index == BinarySearch.leftPointer) {
    // we only want to display the leftpointer[L],only if the control point [index]
    //is equal to the leftPointer[L] in the BinarySearch class itself.
    //doing so will only display the leftPointer[L] that is appropriate to (midPoint + 1) in the BinarySearch class.
    //otherwise if we compare it to the resultValue all numbers to the left will have a leftPointer[L].

    return 'L ';
  } else if (index == BinarySearch.rightPointer) {
    //our control point [index] is now compared to the rightPointer[R] in the BinarySearch class [mid - 1]
    //everything is the same as above, only this time we're checking for the rightPointer[R]
    return 'R ';
  } else if (index == resultValue) {
    //if the control point and resultValue are the same we've found our value
    return 'M ';
  }
  //leave as is to only display L,M,R pointers,whatever character is passed here will be displayed
  //at each condition that isnt met above.
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
Color switchDefaultColor(int index, int resutValue) {
  if (resutValue == -1) {
    // value we're searching for  doesnt exist in our array.
    return Colors.blueGrey;
  } else if (index > resutValue) {
    //the upperbounds of the array will be red
    //the indices to the right of our result/midpoint value is greater.
    return Colors.blue;
  } else if (index < resutValue) {
    //the lowerbounds of the array will be black
    //the indices to the left of our result/midpoint value is smaller.
    return Colors.black;
  } else if (index == resutValue) {
    //highlight the index and value in our array if it exist.
    return Colors.amber;
  }
  //does nothing.
  return Colors.transparent;
}

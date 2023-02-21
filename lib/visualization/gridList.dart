import 'package:flutter/material.dart';
import 'package:visualization/visualization/visualizer.dart';

class GridListBuilder extends StatelessWidget {
  const GridListBuilder({
    required this.arraySet,
    required this.binarySearchResult,
    required this.size,
  }) : super();

  final Set<int> arraySet;
  final int binarySearchResult;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: arraySet.length != null ? arraySet.length : 0,
      itemBuilder: (context, index) {
        return Padding(
          padding: index == binarySearchResult
              ? const EdgeInsets.all(0)
              : const EdgeInsets.all(6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                switchPointer(index, binarySearchResult),
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: switchPointerColor(index, binarySearchResult)),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    width: size.width * 0.10,
                    height: size.height * 0.04,
                    duration: Duration(milliseconds: 1000),
                    decoration: BoxDecoration(
                        border: index == binarySearchResult
                            ? Border.all(color: Colors.white, width: 3)
                            : Border.all(width: 0, color: Colors.transparent),
                        color: switchDefaultColor(index, binarySearchResult),
                        borderRadius: index == binarySearchResult
                            ? BorderRadius.circular(8)
                            : BorderRadius.circular(0)),
                    child: Center(
                        child: Text(
                      '${arraySet.elementAt(index)}',
                      style: TextStyle(
                          color: changeTextColor(index, binarySearchResult),
                          fontSize: index == binarySearchResult ? 14 : 10),
                    )),
                  ),
                  Text('$index',
                      style: TextStyle(
                          color: index == binarySearchResult
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
    );
  }
}

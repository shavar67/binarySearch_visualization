import 'package:flutter/material.dart';
import 'package:visualization/visualization/visualizer.dart';

class Introduction extends StatefulWidget {
  const Introduction({super.key});

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  var questions = [
    'What is binary searhch?',
  ];

  var ans = [
    'Binary Search is a searching algorithm used in a sorted array by repeatedly dividing the search interval in half. The idea of binary search is to use the information that the array is sorted and reduce the time complexity to O(Log n).',
  ];
  bool isDismissed = true;
  double defaultPosition = -400;
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              top: 150,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  shadowColor: isDismissed ? Colors.red : Colors.blue,
                  elevation: isDismissed ? 16 : 8,
                  child: AnimatedContainer(
                    height: isDismissed ? _height * 0.30 : size.height * .15,
                    duration: Duration(milliseconds: 350),
                    child: Container(
                      child: Align(
                        child: RichText(
                          text: TextSpan(
                              text: 'Binary Search Demo',
                              style: TextStyle(fontSize: 18)),
                        ),
                      ),
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              )),
          AnimatedPositioned(
            curve: Curves.fastOutSlowIn,
            left: 4,
            right: 4,
            bottom: defaultPosition,
            duration: const Duration(milliseconds: 500),
            child: Material(
              shadowColor: Colors.purple,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              elevation: 28,
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(16)),
                width: _width * 0.5,
                height: _height * 0.50,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      height: _height,
                      width: _width,
                      child: ListView.builder(
                          itemCount: questions.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                title: Text(questions[index]),
                                subtitle: Text(ans[index]));
                          }),
                    ),
                    isDismissed
                        ? Positioned(
                            left: _width * 0.2,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isDismissed = !isDismissed;
                                  defaultPosition = 30;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 350),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(36),
                                  ),
                                  height: 10,
                                  width: _width * 0.5,
                                ),
                              ),
                            ),
                          )
                        : Positioned(
                            left: _width * 0.2,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isDismissed = !isDismissed;
                                  defaultPosition = -330;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 350),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(36),
                                  ),
                                  width: _width * 0.5,
                                  height: 10,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        child: Icon(
          Icons.navigate_next_outlined,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => Visualizer())));

          setState(() {
            if (!isDismissed) {
              isDismissed = !isDismissed;
              defaultPosition = -330;
            }
          });
        },
      ),
    );
  }
}

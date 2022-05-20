// ignore_for_file: file_names,depend_on_referenced_packages,prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import "package:page_view_indicators/page_view_indicators.dart";

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({Key? key}) : super(key: key);

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  var currentPageValue = 0.0;
  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      setState(() {
        currentPageValue = _pageController.page!;
      });
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NewGradientAppBar(
        title: Text('Gradient PageView'),
        gradient:
            LinearGradient(colors: [Colors.blue, Colors.purple, Colors.red]),
      ),
      body: Stack(
        alignment: FractionalOffset.bottomCenter,
        children: [
          PageView.builder(
            itemBuilder: (context, int position) {
              if (position == currentPageValue.floor()) {
                return Transform(
                    transform: Matrix4.identity()
                      ..rotateX(currentPageValue - position),
                    child: _buildPageView(position));
              } else if (position == currentPageValue.floor() + 1) {
                return Transform(
                    transform: Matrix4.identity()
                      ..rotateX(currentPageValue - position),
                    child: _buildPageView(position));
              } else {
                return _buildPageView(position);
              }
            },
            scrollDirection:
                Axis.horizontal, // it can be vertical Axis.vertical
            itemCount: 5,
            controller: _pageController,
            physics:
                const ClampingScrollPhysics(), // you can choose different physics
            pageSnapping: true,
            onPageChanged: (int position) {
              print(position);
              _currentPageNotifier.value = position;
            }, // on page is called when the page is changes
          ),
          _buildCircleIndicator(),
        ],
      ),
    );
  }

  /* Methods */

  _buildCircleIndicator() {
    return Container(
      margin: EdgeInsets.only(
        bottom: 5.0,
      ),
      child: CirclePageIndicator(
          selectedSize: 12,
          size: 10,
          dotColor: Colors.lightBlue,
          selectedDotColor: Color.fromARGB(255, 196, 90, 90),
          currentPageNotifier: _currentPageNotifier,
          itemCount: 5),
    );
  }

  _buildPageView(int position) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        padding: const EdgeInsets.all(50),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue,
                Colors.red,
              ],
            ),
            borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Text("Gradient PageView $position",
                style: TextStyle(
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ))),
      ),
    );
  }
  /* Methods */

  /*Different Box Decoration Examples*/
/**
 *  BoxDecoration(
            color: Color.fromARGB(255, 51, 126, 177),
            borderRadius: BorderRadius.circular(25)),
 
BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.blue,
                Colors.red,
              ],
            ),
            borderRadius: BorderRadius.circular(20))
 
 BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [
                0.1,
                0.4,
                0.6,
                0.9,
              ],
              colors: [
                Colors.yellow,
                Colors.red,
                Colors.indigo,
                Colors.teal,
              ],
            ),
            borderRadius: BorderRadius.circular(25)),

AppBar(
        title: Text('Gradient PageView'),
        backgroundColor: Colors.blueAccent,
      ),

  NewGradientAppBar(
        title: Text('Gradient PageView'),
        gradient:
            LinearGradient(colors: [Colors.blue, Colors.purple, Colors.red]),
      )          

 */
  /*Different Gradient Examples*/
}

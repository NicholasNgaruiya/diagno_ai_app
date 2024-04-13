import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Half In, Half Out Avatar'),
        ),
        body: Center(
          child: Container(
            width: 150,
            height: 150,
            color: Colors.blue,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  child: Container(
                    width: 75,
                    height: 150,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    width: 75,
                    height: 150,
                    color: Colors.white,
                  ),
                ),
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/avatar.jpg'), // Replace 'assets/avatar.jpg' with your image path
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

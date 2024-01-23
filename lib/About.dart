import 'package:flutter/material.dart';

class About extends StatelessWidget{

  // About part UI Design
  @override
  Widget build(BuildContext context) {
    return 
        Container(
          width: 325.0,
          padding: const EdgeInsets.all(16.0),
          color: const Color.fromARGB(255, 185, 2, 217),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Pui Yee Ng',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.0,
                ),
              ),
              SizedBox(height: 8.0,),
              Text(
                '301366105',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.0,
                ),
              ),
            ],
          ),
        );
  }
}
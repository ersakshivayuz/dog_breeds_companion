
import 'package:flutter/material.dart';

import '../screens/APIBreeds.dart';
import '../screens/LocalBreeds.dart';

buildMyNavBar(BuildContext context) {
  return Container(
    height: 60,
    decoration: BoxDecoration(
      color: Colors.blue,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(onPressed:()=> Navigator.push(context,MaterialPageRoute(builder: (context)=> APIBreeds())), child: Text("APIBreeds")),
        ElevatedButton(onPressed:()=> Navigator.push(context,MaterialPageRoute(builder: (context)=> LocalBreeds())), child: Text("LocalBreeds"))

      ],
    ),
  );
}
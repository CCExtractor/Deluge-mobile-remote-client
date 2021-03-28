import 'package:flutter/material.dart';

//---------------------custom app bar
class CustomAppBar extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
   Path path = new Path();

   path.lineTo(0, size.height) ;
   path.quadraticBezierTo(size.width/4, size.height-40, size.width/2, size.height-20) ;

   path.quadraticBezierTo(3/4 * size.width, size.height, size.width, size.height - 20) ;

   path.lineTo(size.width, 0) ;


    return path ;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    
    return false;
  }


}

//---- custom appbar
import 'package:flutter/material.dart';
import 'package:game_of_life/constants/game.dart';

class FieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Color(0xff995588)
      ..strokeWidth = 2;

    for (int i = 1; i < fieldWidth; i++) {
      Offset startingPoint = Offset(i * cellSize, 0);
      Offset endingPoint = Offset(i * cellSize, size.height);
      canvas.drawLine(startingPoint, endingPoint, paint);
    }

    for (int i = 1; i < fieldHeight; i++) {
      Offset startingPoint = Offset(0, i * cellSize);
      Offset endingPoint = Offset(size.width, i * cellSize);
      canvas.drawLine(startingPoint, endingPoint, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
